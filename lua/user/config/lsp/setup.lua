local servers = {
  "lua_ls", -- lua
  "jsonls", -- json
  "bashls", -- bash
  "clangd", -- c language
  "pylsp", -- python
  "ansiblels", -- ansible
}
local custom_servers = {}
local custom_servers_without_setup = {
  -- handled by rust-tools
  "rust_analyzer", -- rust
}

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok or mason_lspconfig == "require error" then
  return "require error" -- Prevent require loop
end
mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = { exclude = vim.list_extend(custom_servers_without_setup, custom_servers) },
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

-- Install pylsp plugins when mason package is installed/updated
require("mason-registry"):on("package:install:success", require("user.config.lsp.util").mason_post_install)

local function setup_server(lsp, server)
  local opts = {
    on_attach = require("user.config.lsp.handlers").on_attach,
    capabilities = require("user.config.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, "user.config.lsp.settings." .. server) -- Load server-specific settings
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts) -- opts will override conf_opts
  end
  lsp[server].setup(opts)
end

for _, server in pairs(servers) do
  setup_server(lspconfig, server)
end
for _, server in pairs(custom_servers) do
  setup_server(lspconfig, server)
end
