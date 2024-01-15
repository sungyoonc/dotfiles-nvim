return {
  -- rust-tools
  {
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
    config = function()
      require("user.config.lsp.rust-tools")
    end,
  },
}
