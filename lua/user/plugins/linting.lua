return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function()
      require("user.config.lint")
    end,
  },
}
