-- Completion Plugins
local M = {
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("user.config.cmp")
    end,
    dependencies = {
      "hrsh7th/cmp-buffer", -- buffer completions
      "hrsh7th/cmp-path", -- path completions
      "hrsh7th/cmp-cmdline", -- cmdline completions
    },
  },
  { "hrsh7th/cmp-nvim-lua", ft = "lua" }, -- cmp source for neovim Lua API (lazyload when file is .lua)
}

return M
