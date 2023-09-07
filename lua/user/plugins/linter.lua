-- Linter Plugins
local M = {
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("user.config.lint")
    end,
  },
}
return M
