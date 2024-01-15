return {
  -- snippets
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use
  },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require("user.config.cmp")
    end,
    dependencies = {
      { "hrsh7th/cmp-nvim-lua", ft = "lua" }, -- neovim lua api completions
      "hrsh7th/cmp-buffer", -- buffer completions
      "hrsh7th/cmp-path", -- path completions
      "hrsh7th/cmp-cmdline", -- cmdline completions
      "saadparwaiz1/cmp_luasnip", -- snippet completions
    },
  },
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    opts = {},
  },

  -- comments
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
}
