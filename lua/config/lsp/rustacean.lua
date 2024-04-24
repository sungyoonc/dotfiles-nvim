local keymap = vim.keymap.set
vim.g.rustaceanvim = {
  tools = {},
  server = {
    cmd = { "rustup", "run", "stable", "rust-analyzer", "--log-file", vim.fn.tempname() .. "-rust-analyzer.log" },
    on_attach = function(client, bufnr)
      -- load lsp keymaps
      require("config.lsp.handlers").lsp_keymaps(bufnr)

      -- Enable inlay hints
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
    end,
    default_settings = {
      ["rust-analyzer"] = {
        check = { command = "clippy" },
      },
    },
  },
}
