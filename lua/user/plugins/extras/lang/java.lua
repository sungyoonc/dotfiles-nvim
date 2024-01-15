return {
  -- better jdtls intergration
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      require("user.config.lsp.jdtls")
    end,
  },
}
