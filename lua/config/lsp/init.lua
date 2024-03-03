-- Only continue when nvim-lspconfig is installed
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("config.lsp.setup")
require("config.lsp.handlers").setup()