return {
  -- rust-tools
  {
    "mrcjkb/rustaceanvim",
    version = "*",
    ft = { "rust" },
    init = function()
      require("config.lsp.rustacean")
    end,
  },
}
