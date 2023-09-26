local util = require("conform.util")

local M = {}

M.custom_stylua = {
  meta = {
    url = "https://github.com/JohnnyMorganz/StyLua",
    description = "An opinionated code formatter for Lua.",
  },
  command = "stylua",
  args = {
    "--search-parent-directories",
    "--stdin-filepath",
    "$FILENAME",
    "--config-path",
    vim.fn.stdpath("config") .. "/lua/user/config/formatter/options/stylua.toml",
    "-",
  },
  range_args = function(ctx)
    local start_offset, end_offset = util.get_offsets_from_range(ctx.buf, ctx.range)
    return {
      "--search-parent-directories",
      "--stdin-filepath",
      "$FILENAME",
      "--config-path",
      vim.fn.stdpath("config") .. "/lua/user/config/formatter/options/stylua.toml",
      "--range-start",
      tostring(start_offset),
      "--range-end",
      tostring(end_offset),
      "-",
    }
  end,
  cwd = util.root_file({
    ".stylua.toml",
    "stylua.toml",
  }),
}

M.custom_clang_format = {
  meta = {
    url = "https://www.kernel.org/doc/html/latest/process/clang-format.html",
    description = "Tool to format C/C++/… code according to a set of rules and heuristics.",
  },
  command = "clang-format",
  args = {
    "-assume-filename",
    "$FILENAME",
    "-style",
    "file:" .. vim.fn.stdpath("config") .. "/lua/user/config/formatter/options/clang-format.yml",
    true,
  },
  range_args = function(ctx)
    local start_offset, end_offset = util.get_offsets_from_range(ctx.buf, ctx.range)
    local length = end_offset - start_offset
    return {
      "-assume-filename",
      "$FILENAME",
      "-style",
      "file:" .. vim.fn.stdpath("config") .. "/lua/user/config/formatter/options/clang-format.yml",
      "--offset",
      tostring(start_offset),
      "--length",
      tostring(length),
    }
  end,
}

return M
