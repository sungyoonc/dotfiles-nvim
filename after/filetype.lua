-- For more info on filetype visit https://neovim.io/doc/user/lua.html#vim.filetype.add()
-- For more patterns visit https://neovim.io/doc/user/luaref.html#lua-pattern

vim.filetype.add({
  pattern = {
    [".*/hypr/.*%.conf"] = "hypr",
  },
})
