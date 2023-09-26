-- Only continue when nvim-lspconfig is installed
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("user.config.lsp.setup")
require("user.config.lsp.handlers").setup()
