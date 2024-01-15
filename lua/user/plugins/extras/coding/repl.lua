return {
  -- repl
  {
    "Vigemus/iron.nvim",
    ft = { "python" },
    config = function()
      require("user.config.iron")
    end,
  },
}
