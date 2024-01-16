return {
  -- better jdtls intergration
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      require("config.lsp.jdtls")
    end,
  },
}
