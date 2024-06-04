local wk = require("which-key")

-- set group name
wk.register({
  ["<leader>"] = {
    l = {
      name = "+lsp",
      c = { name = "+codeaction", ["🚫"] = "which_key_ignore" },
      r = { name = "+rename", ["🚫"] = "which_key_ignore" },
    },
    u = { name = "+toggle" },
    v = { name = "+diagnostics" },
    p = { name = "+telescope" },
    r = { name = "+repl" },
    f = { name = "+file" },
    d = {
      name = "+dap",
      l = { name = "+logpoint", ["🚫"] = "which_key_ignore" },
    },
  },
})
