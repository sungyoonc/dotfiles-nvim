require "user.options"
require "user.keymaps" -- Load mapleader keymap before lazy

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)

-- https://github.com/folke/lazy.nvim#%EF%B8%8F-configuration
local lazyconfig = {
  defaults = {
    lazy = false -- should plugins be lazy-loaded?
  }
}
-- Setup lazy
require("lazy").setup("user.plugins", lazyconfig)

require "user.colorscheme"
require "user.cmp"
require "user.lsp" -- directory
