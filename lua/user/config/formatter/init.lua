-- Utilities for creating configurations
local util = require("formatter.util")

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    --
    -- https://github.com/mhartington/formatter.nvim/tree/master/lua/formatter/filetypes
    lua = {
      -- require("formatter.filetypes.lua").stylua,
      function()
        return {
          exe = "stylua",
          args = {
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--config-path",
            util.escape_path(vim.fn.stdpath("config") .. "/lua/user/config/formatter/options/stylua.toml"),
            "--",
            "-",
          },
          stdin = true,
        }
      end,
    },
    python = {
      require("formatter.filetypes.python").black,
    },
    rust = {
      require("formatter.filetypes.rust").rustfmt,
    },
    sh = {
      require("formatter.filetypes.sh").shfmt,
    },
    zsh = {
      require("formatter.filetypes.sh").shfmt,
    },
    c = {
      require("formatter.filetypes.c").clangformat,
    },
    java = {
      require("formatter.filetypes.java").clangformat,
    },

    -- -- Use the special "*" filetype for defining formatter configurations on
    -- -- any filetype
    -- ["*"] = {
    --   -- "formatter.filetypes.any" defines default configurations for any
    --   -- filetype
    --   require("formatter.filetypes.any").remove_trailing_whitespace
    -- },
  },
})
