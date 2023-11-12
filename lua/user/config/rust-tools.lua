local rt = require("rust-tools")

rt.setup({
  tools = {
    inlay_hints = { auto = false },
  },
  server = {
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
    on_attach = function(client, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })

      -- Enable inlay hints
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint(bufnr, true)
      end
    end,
  },
})
