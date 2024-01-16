return {
  -- repl
  {
    "Vigemus/iron.nvim",
    ft = { "python" },
    config = function()
      require("config.iron")
    end,
  },
}
