return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- lsp completions
    },
    config = function()
      require("user.config.lsp")
    end,
  },

  -- lsp servers
  {
    "williamboman/mason.nvim", -- simple to use language server installer
    build = ":MasonUpdate",
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

  -- dap, linter, formatters
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("user.config.mason_tool_installer")
    end,
  },
}
