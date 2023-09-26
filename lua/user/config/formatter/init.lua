local conform = require("conform")

-- Setup custom formatters
conform.formatters = require("user.config.formatter.custom")

-- Full Options: https://github.com/stevearc/conform.nvim#options
conform.setup({
  formatters_by_ft = {
    -- Supported: https://github.com/stevearc/conform.nvim#formatters
    lua = { "custom_stylua" },
    c = { "custom_clang_format" },
    rust = { "rustfmt" },
    java = { "custom_clang_format" },
    python = { "isort", "black" }, -- run sequentially
    sh = { "shfmt" },
    zsh = { "shfmt" },
  },
  -- Set the log level. Use `:ConformInfo` to see the location of the log file.
  log_level = vim.log.levels.ERROR,
  -- Conform will notify you when a formatter errors
  notify_on_error = true,
})

vim.api.nvim_create_user_command("Format", function()
  require("conform").format({ lsp_fallback = true })
end, {})
