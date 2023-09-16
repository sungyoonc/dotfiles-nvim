-- Utilities for creating configurations
local util = require("formatter.util")

local M = {}

M.stylua = function()
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
end

M.clangformat = function()
  return {
    exe = "clang-format",
    args = {
      "-assume-filename",
      util.escape_path(util.get_current_buffer_file_name()),
      "-style",
      "file:" .. util.escape_path(vim.fn.stdpath("config") .. "/lua/user/config/formatter/options/clang-format.yml"),
    },
    stdin = true,
    try_node_modules = true,
  }
end

return M
