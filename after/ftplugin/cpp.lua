local filepath = vim.fn.expand('%:p')
filepath = string.lower(filepath)

if filepath:match("hyprland") then
  vim.opt.binary = true -- for hyprland git no end line thingy
end

vim.opt.tabstop = 8
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
