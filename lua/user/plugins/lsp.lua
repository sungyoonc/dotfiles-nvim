-- Language Server Plugins
local M = {
  -- Language Server
  {
    "neovim/nvim-lspconfig", -- enable LSP
    dependencies = {
      "williamboman/mason-lspconfig.nvim", -- simple to use language server installer
      "hrsh7th/cmp-nvim-lsp", -- lsp completions
    },
    config = function()
      require("user.config.lsp")
    end,
  },
  {
    "williamboman/mason.nvim", -- simple to use language server installer
    opts = {
      ui = {
        border = "none",
        icons = {
          package_installed = "",
          package_pending = "󱍸",
          package_uninstalled = "",
        },
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
    },
  },

  -- Language Specific
  -- {
  --   "simrat39/rust-tools.nvim",
  --   config = function()
  --     require "user.config.rust-tools"
  --   end,
  -- }, -- better rust lsp intergration
  {
    "pearofducks/ansible-vim",
    ft = { "yaml" },
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      require("user.config.lsp.jdtls")
    end,
  },
}

return M
