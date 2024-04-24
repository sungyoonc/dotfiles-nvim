return {
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.harpoon")
    end,
  },
  {
    "echasnovski/mini.files",
    keys = {
      {
        "<leader>fm",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (directory of current file)",
      },
      {
        "<leader>fM",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
    config = function()
      require("config.mini-files")
    end,
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      "stevearc/dressing.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1, -- if make is available
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    event = "VeryLazy",
    config = function()
      require("config.telescope")
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
    config = function()
      require("config.which-key")
    end,
    opts = {},
  },

  -- diagnostic list
  -- TODO: get configuration from github
  {
    "folke/trouble.nvim",
    lazy = true,
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
    config = function()
      require("undotree").setup()
      vim.keymap.set("n", "<leader>u", require("undotree").toggle, { desc = "Toggle Undotree" })
    end,
    keys = { { "<leader>u", desc = "Toggle Undotree" } },
  },

  -- terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = {
      "ToggleTerm",
      "ToggleTermToggleAll",
      "TermExec",
      "TermSelect",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection",
      "ToggleTermSetName",
    },
    keys = { { "<leader>g", desc = "Toggle Lazygit" } },
    config = function()
      require("config.toggleterm")
    end,
  },
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<c-w>z", desc = "Toggle Zoom" },
      { "<leader>zz", desc = "Toggle Zen Mode" },
      { "<leader>zZ", desc = "Toggle Deep Zen Mode" },
    },
    init = function()
      require("which-key").register({
        ["<leader>"] = {
          z = { name = "+zen" },
        },
      })
    end,
    config = function()
      require("config.zen-mode")
    end,
  },
  -- nice notification ui
  {
    "j-hui/fidget.nvim",
    opts = {
      progress = {
        lsp = {
          progress_ringbuf_size = 1024,
        },
      },
    },
  },
  {
    "alohaia/fcitx.nvim",
    event = "InsertEnter",
    config = function()
      require("fcitx")({})
    end,
  },
}
