return {
  {
    "mhartington/formatter.nvim",
    cmd = {
      "Format",
    },
    config = function()
      require("user.config.formatter")
    end,
  },
}
