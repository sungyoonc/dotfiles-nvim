-- List of plugins
return {
  -- Base plugins
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins

  -- Colorschemes
  { "rose-pine/neovim", name = "rose-pine",  lazy = true },
  { "catppuccin/nvim",  name = "catppuccin", lazy = true },

  -- Quality of life plugins
  {
    "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
    event = "InsertEnter",
    opts = {},
  },
  {
    "numToStr/Comment.nvim",
    opts = {},
  },
  {
    "brenoprata10/nvim-highlight-colors",
    opts = {},
  },

  -- Completion plugins
  "hrsh7th/nvim-cmp",                     -- The completion plugin
  "hrsh7th/cmp-buffer",                   -- buffer completions
  "hrsh7th/cmp-path",                     -- path completions
  "hrsh7th/cmp-cmdline",                  -- cmdline completions
  "hrsh7th/cmp-nvim-lsp",                 -- lsp completions
  { "hrsh7th/cmp-nvim-lua", ft = "lua" }, -- cmp source for neovim Lua API (lazyload when file is .lua)

  -- Language Server
  "neovim/nvim-lspconfig",             -- enable LSP
  "williamboman/mason.nvim",           -- simple to use language server installer
  "williamboman/mason-lspconfig.nvim", -- simple to use language server installer
  {                                    -- TODO: get configuration from github
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  -- Language Specific
  -- "simrat39/rust-tools.nvim", -- better rust lsp intergration

  -- Snippets
  {
    "L3MON4D3/LuaSnip",                                --snippet engine
    dependencies = { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use
  },
  "saadparwaiz1/cmp_luasnip",                          -- snippet completions

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  "nvim-telescope/telescope-media-files.nvim",

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
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
