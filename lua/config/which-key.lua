local wk = require("which-key")

-- set group name
wk.register({
  ["<leader>"] = {
    l = { name = "+lsp" },
    v = { name = "+diagnostics" },
    p = { name = "+telescope" },
    r = { name = "+repl" },
    f = { name = "+file" },
    d = { name = "+dap" },
  },
})
