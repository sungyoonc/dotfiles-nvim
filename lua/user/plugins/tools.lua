-- Quality of Life Plugins
local M = {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
    config = function()
      require "user.config.autopairs"
    end
  },

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Preview colors
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    opts = {},
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require "user.config.treesitter"
    end
  },

  { -- TODO: get configuration from github
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {},
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
      "nvim-telescope/telescope-media-files.nvim",
    },
    keys = {
      { "<leader>f", desc = "Telescope" },
    },
    cmd = {
      "Telescope"
    },
    config = function()
      require "user.config.telescope"
    end
  },


  -- Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
  },
}

return M
