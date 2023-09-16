local M = {
  {
    "mfussenegger/nvim-dap",
    event = { "BufReadPre", "BufNewFile", "InsertEnter" },
    dependencies = { { "rcarriga/nvim-dap-ui", opts = {} } },
    config = function()
      require("user.config.dap")
    end,
  },
}

return M
