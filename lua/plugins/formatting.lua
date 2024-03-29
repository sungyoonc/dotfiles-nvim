return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  lazy = true,
  event = { "BufWritePre" },
  cmd = { "ConformInfo", "Format" },
  keys = {
    { "<leader>lf", mode = { "n", "v" }, desc = "Format buffer" },
  },
  config = function()
    require("config.formatting")
  end,
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
