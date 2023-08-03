local servers = {
  "lua_ls", -- lua
  "jsonls", -- json
  "bashls", -- bash
  "rust_analyzer", -- rust
  "clangd", -- c language
  "jdtls", -- java
  "pyright", -- python
  "jedi_language_server", -- python
}

--[[ local formatters = {
  "shfmt"
} ]]

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "",
			package_pending = "󱍸",
			package_uninstalled = "",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}
local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok or mason == "require error" then
	return "require error" -- Prevent require loop
end
mason.setup(settings)
local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok or mason_lspconfig == "require error" then
	return "require error" -- Prevent require loop
end
mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server) -- Load server-specific settings
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end
	lspconfig[server].setup(opts)
end

