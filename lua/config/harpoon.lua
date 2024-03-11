local harpoon = require("harpoon")
harpoon:setup()

local keymap = vim.keymap.set
keymap("n", "<leader>a", function()
  harpoon:list():append()
end, { desc = "Append to Harpoon" })
keymap("n", "<C-s>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Toogle Harpoon Menu" })

keymap("n", "<C-j>", function()
  harpoon:list():select(1)
end, { desc = "Harpoon 1" })
keymap("n", "<C-k>", function()
  harpoon:list():select(2)
end, { desc = "Harpoon 2" })
keymap("n", "<C-l>", function()
  harpoon:list():select(3)
end, { desc = "Harpoon 3" })
-- Real terminal does not recognize Ctrl-;
-- But terminal emulators(alacritty) can send ANSI escape code magic to neovim, so it can use C-;
-- Control Sequence Introducer + Unicode Decimal + Modifier + u (Stands for unicode)
-- \u001b[                       59              ; 5          u
keymap("n", "<C-;>", function()
  harpoon:list():select(4)
end, { desc = "Harpoon 4" })

-- Toggle previous & next buffers stored within Harpoon list
keymap("n", "<C-S-K>", function()
  harpoon:list():prev()
end, { desc = "Harpoon Previous" })
keymap("n", "<S-NL>", function() -- <S-NL> is <C-S-J>
  harpoon:list():next()
end, { desc = "Harpoon Next" })
