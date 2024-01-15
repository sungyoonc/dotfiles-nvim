return {
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    config = function()
      require("user.config.treesitter")
    end,
  },
}
