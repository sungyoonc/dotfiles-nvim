local conform = require("conform")
local util = require("conform.util")

-- Full Options: https://github.com/stevearc/conform.nvim#options
conform.setup({
  formatters_by_ft = {
    -- Supported: https://github.com/stevearc/conform.nvim#formatters
    lua = { "stylua" },
    rust = { "rustfmt" },
    c = { "clang_format" },
    java = { "clang_format" },
    python = { "isort", "black" }, -- run sequentially
    sh = { "shfmt" },
    zsh = { "shfmt" },
  },
  -- Set the log level. Use `:ConformInfo` to see the location of the log file.
  log_level = vim.log.levels.ERROR,
  -- Conform will notify you when a formatter errors
  notify_on_error = true,
})

-- Add args to existing formatters
--   https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#add-extra-arguments-to-a-formatter-command
local stylua = require("conform.formatters.stylua")
conform.formatters.stylua = vim.tbl_deep_extend("force", stylua, {
  args = util.extend_args(
    stylua.args,
    { "--config-path", vim.fn.stdpath("config") .. "/lua/user/config/formatter/options/stylua.toml" }
  ),
  range_args = util.extend_args(
    stylua.range_args,
    { "--config-path", vim.fn.stdpath("config") .. "/lua/user/config/formatter/options/stylua.toml" }
  ),
})

local clang_format = require("conform.formatters.clang_format")
conform.formatters.clang_format = vim.tbl_deep_extend("force", clang_format, {
  args = util.extend_args(
    clang_format.args,
    { "-style", "file:" .. vim.fn.stdpath("config") .. "/lua/user/config/formatter/options/clang-format.yml" }
  ),
  range_args = util.extend_args(
    clang_format.range_args,
    { "-style", "file:" .. vim.fn.stdpath("config") .. "/lua/user/config/formatter/options/clang-format.yml" }
  ),
})

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
