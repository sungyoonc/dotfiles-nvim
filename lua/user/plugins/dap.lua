local M = {
  {
    "mfussenegger/nvim-dap",
    dependencies = { { "rcarriga/nvim-dap-ui", opts = {} } },
    config = function()
      require("user.config.dap")
    end,
  },
}

return M
