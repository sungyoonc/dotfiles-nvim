local custom = require("user.config.formatter.custom")

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
      custom.stylua,
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
      custom.clangformat,
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
