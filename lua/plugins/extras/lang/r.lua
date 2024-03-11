return {
  {
    "R-nvim/R.nvim",
    ft = "r",
    config = function()
      local wk = require("which-key")
      require("r").setup({})
      wk.register({
        ["<localleader>"] = {
          -- group name only shows up when it has a binding inside.
          s = { name = "+send", ["🚫"] = "which_key_ignore" },
          v = { name = "+view", ["🚫"] = "which_key_ignore" },
        },
      })
      -- wk.register({
      --   s = { name = "+send" },
      --   v = { name = "+view" },
      -- }, { prefix = "<localleader>" })
    end,
  },
  {
    "R-nvim/cmp-r",
    ft = "r",
    config = function()
      require("cmp_r").setup({
        filetype = { "r", "rmd", "quarto" },
      })
    end,
  },
}
