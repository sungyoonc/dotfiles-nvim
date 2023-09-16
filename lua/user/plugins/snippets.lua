-- Snippets Plugins
local M = {
  {
    "L3MON4D3/LuaSnip", --snippet engine
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use
  },
  { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" }, -- snippet completions
}

return M
