local oil = require("oil")

-- https://github.com/stevearc/oil.nvim#options
oil.setup()

vim.keymap.set("n", "<leader>fm", function()
  if vim.bo.filetype ~= "oil" then
    oil.open()
  else
    oil.close()
  end
end, { desc = "Open directory of the current file" })

vim.keymap.set("n", "<leader>fM", function()
  if vim.bo.filetype ~= "oil" then
    oil.open(vim.uv.cwd())
  else
    oil.close()
  end
end, { desc = "Open current working directory" })
