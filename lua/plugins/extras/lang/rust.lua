return {
  -- rust-tools
  {
    "mrcjkb/rustaceanvim",
    version = "^3",
    ft = { "rust" },
    init = function()
      require("config.lsp.rustacean")
    end,
  },
}
