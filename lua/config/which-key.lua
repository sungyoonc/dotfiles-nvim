local wk = require("which-key")

-- Add groups
wk.add({
  -- LSP groups
  { "<leader>l", group = "+lsp" },
  { "<leader>lc", group = "+codeaction" },
  { "<leader>lr", group = "+rename" },
  { "<leader>v", group = "+diagnostics" },

  -- DAP groups
  { "<leader>d", group = "+dap" },
  { "<leader>dl", group = "+logpoint" },

  { "<leader>f", group = "+file" },
  { "<leader>u", group = "+toggle" },
  { "<leader>p", group = "+telescope" },
  { "<leader>r", group = "+repl" },
})
