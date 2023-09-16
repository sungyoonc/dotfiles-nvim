-- Linter Plugins
local M = {
  {
    "mfussenegger/nvim-lint",
    event = "BufWritePre",
    config = function()
      require("user.config.lint")
    end,
  },
}
return M
