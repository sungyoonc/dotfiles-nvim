-- For more info on filetype visit https://neovim.io/doc/user/lua.html#vim.filetype.add()
-- For more patterns visit https://neovim.io/doc/user/luaref.html#lua-pattern

local pattern = {}
local filename = {}

-- hyprlang
pattern[".*/hypr.*/.*%.conf"] = "hyprlang" -- hyprland configs
filename[".*%.hl"] = "hyprlang" -- other hyprlang configs

-- leetcode.nvim
filename["leetcode.nvim"] = "leetcode.nvim"

vim.filetype.add({
  pattern = pattern,
  filename = filename,
})
