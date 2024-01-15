vim.cmd([[
try
  colorscheme catppuccin-mocha
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])

vim.cmd([[
hi DiagnosticUnderlineError gui=undercurl
hi DiagnosticUnderlineWarn gui=undercurl
hi DiagnosticUnderlineInfo gui=undercurl
hi DiagnosticUnderlineHint gui=undercurl
hi DiagnosticUnderlineOk gui=undercurl
]])
