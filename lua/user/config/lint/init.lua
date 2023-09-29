local lint = require("lint")

lint.linters_by_ft = {
  python = {
    "ruff",
  },
  cpp = {
    "cpplint",
  },
  ansible = {
    "ansible_lint",
  },
}

-- Clone from another ft
lint.linters_by_ft.c = lint.linters_by_ft.cpp

-- autocmd
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
