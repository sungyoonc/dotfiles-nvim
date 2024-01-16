return {
  -- rust-tools
  {
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
    config = function()
      require("config.lsp.rust-tools")
    end,
  },
}
