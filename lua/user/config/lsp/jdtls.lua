local java_cmds = vim.api.nvim_create_augroup("java_cmds", { clear = true })
local root_files = {
  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  ".git",
  "mvnw",
  "gradlew",
  "pom.xml",
  "build.gradle",
}
local features = {
  codelens = {
    enabled = true,
  },

  debugger = {
    -- If `nvim-dap` and `java-debug-adapter` is installed.
    enabled = true,
    test = {
      -- If `java-test` is installed
      enabled = false,
    },
  },
}

local function workspace_dir()
  -- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local dir = vim.fn.fnamemodify("~/.java/jdtls/workspace/", ":p") .. project_name
  return dir
end

local jdtls_setup = {
  settings = {
    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    java = {
      inlayHints = { parameterNames = { enabled = "all" } },
    },
  },

  init_options = {
    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    bundles = {
      vim.fn.stdpath("data") .. "/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar",
    },
  },

  -- stylua: ignore
  cmd = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    -- stylua: ignore

    -- 💀
    "java", -- or '/path/to/java17_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    -- 💀
    "-jar", vim.fn.stdpath("data") .. "/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version

    -- 💀
    "-configuration", vim.fn.stdpath("data") .. "/mason/share/jdtls/config",
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.

    -- 💀
    -- See `data directory configuration` section in the README
    "-data", workspace_dir(),
  },
}

local function enable_codelens(bufnr)
  pcall(vim.lsp.codelens.refresh)

  vim.api.nvim_create_autocmd("BufWritePost", {
    buffer = bufnr,
    group = java_cmds,
    desc = "refresh codelens",
    callback = function()
      pcall(vim.lsp.codelens.refresh)
    end,
  })
end

local function enable_debugger(bufnr, test_enabled)
  require("jdtls").setup_dap({ hotcodereplace = "auto" })
  require("jdtls.dap").setup_dap_main_class_configs()

  if test_enabled then
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "<leader>df", "<cmd>lua require('jdtls').test_class()<cr>", opts)
    vim.keymap.set("n", "<leader>dn", "<cmd>lua require('jdtls').test_nearest_method()<cr>", opts)
  end
end

local function jdtls_on_attach(client, bufnr)
  if features.debugger.enabled then
    enable_debugger(bufnr, features.debugger.test.enabled)
  end

  if features.codelens.enabled then
    enable_codelens(bufnr)
  end

  -- The following mappings are based on the suggested usage of nvim-jdtls
  -- https://github.com/mfussenegger/nvim-jdtls#usage

  local opts = { buffer = bufnr }
  vim.keymap.set("n", "<A-o>", "<cmd>lua require('jdtls').organize_imports()<cr>", opts)
  vim.keymap.set("n", "crv", "<cmd>lua require('jdtls').extract_variable()<cr>", opts)
  vim.keymap.set("x", "crv", "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", opts)
  vim.keymap.set("n", "crc", "<cmd>lua require('jdtls').extract_constant()<cr>", opts)
  vim.keymap.set("x", "crc", "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", opts)
  vim.keymap.set("x", "crm", "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>", opts)
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = jdtls_setup.cmd,
  root_dir = require("jdtls.setup").find_root(root_files),
  on_attach = jdtls_on_attach,
  settings = jdtls_setup.settings,
  init_options = jdtls_setup.init_options,
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
--
-- currently, java ft detection is managed by lazy.nvim
--
-- To make it be managed without lazy.nvim consider making a ftplugin or autocmd
-- - ftplugin: https://github.com/mfussenegger/nvim-jdtls#configuration-quickstart
-- - autocmd: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/guides/setup-with-nvim-jdtls.md#working-with-nvim-jdtls
require("jdtls").start_or_attach(config)
