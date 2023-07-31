-- Automatically install packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- List of plugins
return packer.startup(function(use)
  -- Base plugins
  use "wbthomason/packer.nvim"
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter

  -- Colorschemes
  use { "rose-pine/neovim", as = "rose-pine" }
  use { "catppuccin/nvim", as = "catppuccin" }

  -- Quality of life plugins
  use {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end
  }
  use {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require('nvim-highlight-colors').setup()
    end
  }

  -- Completion plugins
  use "hrsh7th/nvim-cmp"                     -- The completion plugin
  use "hrsh7th/cmp-buffer"                   -- buffer completions
  use "hrsh7th/cmp-path"                     -- path completions
  use "hrsh7th/cmp-cmdline"                  -- cmdline completions
  use "hrsh7th/cmp-nvim-lsp"                 -- lsp completions
  use { "hrsh7th/cmp-nvim-lua", ft = "lua" } -- cmp source for neovim Lua API (lazyload when file is .lua)

  -- Language Server
  use "neovim/nvim-lspconfig" -- enable LSP
  use {
    "williamboman/mason.nvim",
    run = ":MasonUpdate",                 -- :MasonUpdate updates registry contents
  }                                       -- simple to use language server installer
  use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer
  use 'jose-elias-alvarez/null-ls.nvim'   -- LSP diagnostics and code actions
  use { -- TODO: get configuration from github
    "folke/trouble.nvim",
    requires = {"nvim-tree/nvim-web-devicons"}
  }

  -- Language Specific
  -- use 'simrat39/rust-tools.nvim' -- better rust lsp intergration

  -- Snippets
  use "L3MON4D3/LuaSnip"             --snippet engine
  use "saadparwaiz1/cmp_luasnip"     -- snippet completions
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use 'nvim-telescope/telescope-media-files.nvim'

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  -- Markdown Preview
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end
end)
