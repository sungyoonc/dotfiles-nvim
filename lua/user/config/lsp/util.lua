local M = {}
M.mason_post_install = function(pkg)
  if pkg.name ~= "python-lsp-server" then
    return
  end
  -- https://github.com/python-lsp/python-lsp-server#3rd-party-plugins
  local plugin_list = {
    "python-lsp-ruff",
    -- "pyls-memestra",
    "pylsp-mypy",
  }

  -- https://www.reddit.com/r/neovim/comments/ulx17m/comment/i7y5927/
  vim.schedule(function()
    vim.cmd("PylspInstall " .. table.concat(plugin_list, " "))
  end)
end
return M
