local servers = {
  "rust_analyzer", -- Disabled due to rust-tools
  "lua_ls",
	-- "pyright",
	"jsonls",
  "bashls",
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

-- Fix self importing bug
if package.searchpath('mason', package.path) == "./mason.lua" then
  return
end
require("mason").setup(settings)
require("mason-lspconfig").setup({
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

--[[ require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
}) ]]