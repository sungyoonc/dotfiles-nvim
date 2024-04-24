local jdtls = require("jdtls")
local java_cmds = vim.api.nvim_create_augroup("java_cmds", { clear = true })
local root_files = {
  -- 💀
  -- One dedicated LSP server & client will be started per unique root_dir
  main = {
    -- Git
    ".git",
    -- Ant
    "build.xml",
    -- Maven
    "mvnw",
    "pom.xml",
    -- Gradle
    "gradlew",
    "settings.gradle",
    "settings.gradle.kts",
    -- Intellij
    ".idea",
  },
  fallback = {
    -- Gradle multi-module project
    "build.gradle",
    "build.gradle.kts",
  },
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

local root_dir = jdtls.setup.find_root(root_files.main) or jdtls.setup.find_root(root_files.fallback)

local function workspace_dir()
  -- See `data directory configuration` section in the README
  -- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
  local dir

  if root_dir == nil then
    dir = vim.fn.fnamemodify("~/.java/jdtls/workspace/standalone/", ":p")
  else
    local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
    dir = vim.fn.fnamemodify("~/.java/jdtls/workspace/projects/", ":p") .. project_name
  end
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
    bundles = {
      vim.fn.stdpath("data") .. "/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar",
    },
  },

  -- stylua: ignore
  cmd = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
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

    -- 💀
    "-configuration", vim.fn.stdpath("data") .. "/mason/share/jdtls/config",

    -- 💀
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
    local keymap = vim.keymap.set
    keymap("n", "<leader>ltc", jdtls.test_class, { desc = "Java Test Class", buffer = bufnr })
    keymap("n", "<leader>ltn", jdtls.test_nearest_method, { desc = "Java Test Nearest Method", buffer = bufnr })
  end
end

local function jdtls_on_attach(client, bufnr)
  if features.debugger.enabled then
    enable_debugger(bufnr, features.debugger.test.enabled)
  end

  if features.codelens.enabled then
    enable_codelens(bufnr)
  end

  vim.lsp.inlay_hint.enable(true) -- using bufnr as argument does not work for some reason

  -- The following mappings are based on the suggested usage of nvim-jdtls
  -- https://github.com/mfussenegger/nvim-jdtls#usage

  ---@param desc string
  local function opts(desc)
    return { desc = desc, buffer = bufnr }
  end

  local keymap = vim.keymap.set
  keymap("n", "<A-o>", "<cmd>lua require('jdtls').organize_imports()<cr>", opts("Organize Imports"))
  keymap("n", "<leader>lev", "<cmd>lua require('jdtls').extract_variable()<cr>", opts("Extract Variable"))
  keymap("x", "<leader>lev", "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", opts("Extract Variable"))
  keymap("n", "<leader>lec", "<cmd>lua require('jdtls').extract_constant()<cr>", opts("Extract Constant"))
  keymap("x", "<leader>lec", "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", opts("Extract Constant"))
  keymap("x", "<leader>lem", "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>", opts("Extract Method"))
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = jdtls_setup.cmd,
  root_dir = root_dir,
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
jdtls.start_or_attach(config)
