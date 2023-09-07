local lint = require("lint")

lint.linters_by_ft = {
  python = {
    "ruff"
  },
  cpp = {
    "cpplint"
  }
}

-- Clone from another ft
lint.linters_by_ft.c = lint.linters_by_ft.cpp

-- autocmd
vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
    callback = function()
        local lint_ok, lint = pcall(require, "lint")
        if lint_ok then
            lint.try_lint()
        end
    end,
})
