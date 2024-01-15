return {
  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-media-files.nvim",
    },
    keys = {
      { "<leader>f", desc = "Telescope" },
    },
    cmd = {
      "Telescope",
    },
    config = function()
      require("user.config.telescope")
    end,
  },

  -- key binding popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },

  -- diagnostic list
  -- TODO: get configuration from github
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = {
      "Trouble",
      "TroubleToggle",
    },
    opts = {},
  },

  -- find all todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope", "TodoQuickfix", "TodoLocList" },
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- undotree (lua version)
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = {
      { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
}
