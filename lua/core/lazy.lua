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

-- Configurations
-- https://github.com/folke/lazy.nvim#%EF%B8%8F-configuration
local lazyconfig = {
  spec = {
    { import = "plugins" },
    { import = "plugins.extras.coding" },
    { import = "plugins.extras.lang" },
    { import = "plugins.extras.lsp" },
  },
  defaults = {
    lazy = false, -- should plugins be lazy-loaded?
  },
  change_detection = {
    notify = false,
  },
}

-- Setup lazy
require("lazy").setup(lazyconfig)
