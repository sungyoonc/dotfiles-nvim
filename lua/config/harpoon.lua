local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-s>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<M-j>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<M-k>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<M-l>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<M-;>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<M-S-k>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<M-S-j>", function() harpoon:list():next() end)
