return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { { "rcarriga/nvim-dap-ui", opts = {} } },
    config = function()
      require("config.dap")
    end,
  },
}
