-- Use ":lua =vim.lsp.buf_get_clients()"
-- to get current buffer's language server options
return {
  completionProvider = false, -- Disabling to be compatible with autopairs
  -- https://github.com/windwp/nvim-autopairs/pull/404
  definitionProvider = false,
  documentHighlightProvider = false,
  documentSymbolProvider = false,
  executeCommandProvider = false,
  referencesProvider = false,
  renameProvider = false,
  typeDefinitionProvider = false,
}
