require("toggleterm").setup({})

-- lazygit float
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  direction = "float",
  float_opts = {
    border = "curved",
    width = function()
      return math.ceil(vim.o.columns * 0.925)
    end,
    height = function()
      return math.ceil(vim.o.lines * 0.85)
    end,
  },
  hidden = true,
})

local function _lazygit_toggle()
  lazygit:toggle()
end

vim.keymap.set("n", "<leader>g", _lazygit_toggle, { desc = "Toggle lazygit", remap = false, silent = true })
