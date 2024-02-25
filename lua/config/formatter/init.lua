local conform = require("conform")

-- Full Options: https://github.com/stevearc/conform.nvim#options
conform.setup({
  formatters_by_ft = {
    -- Supported: https://github.com/stevearc/conform.nvim#formatters
    lua = { "stylua" },
    c = { "clang_format" },
    java = { "clang_format" },
    python = { "ruff_format" }, -- run sequentially
    sh = { "shfmt" },
    zsh = { "shfmt" },
  },
  -- Set the log level. Use `:ConformInfo` to see the location of the log file.
  log_level = vim.log.levels.ERROR,
  -- Conform will notify you when a formatter errors
  notify_on_error = true,
})

-- Add args to existing formatters
--   https://github.com/stevearc/conform.nvim#customizing-formatters
conform.formatters.stylua = {
  prepend_args = { "--config-path", vim.fn.stdpath("config") .. "/lua/config/formatter/options/stylua.toml" },
}

conform.formatters.clang_format = {
  prepend_args = {
    "-style",
    "file:" .. vim.fn.stdpath("config") .. "/lua/config/formatter/options/clang-format.yml",
  },
}

conform.formatters.shfmt = {
  prepend_args = { "-i=4" },
}

-- :Format command
vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  conform.format({ async = true, lsp_fallback = true, range = range })
end, { range = true })
