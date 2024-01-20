---@param desc string
local function opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

local keymap = vim.keymap.set

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- diagnostics
keymap("n", "<leader>vd", function()
  require("trouble").toggle("workspace_diagnostics")
end, opts("Toggle Trouble"))
keymap("n", "]d", function()
  require("trouble").open("workspace_diagnostics")
  require("trouble").next({ skip_groups = true, jump = true })
end, opts("Next Diagnostic"))
keymap("n", "[d", function()
  require("trouble").open("workspace_diagnostics")
  require("trouble").previous({ skip_groups = true, jump = true })
end, opts("Previous Diagnostic"))
keymap("n", "gl", vim.diagnostic.open_float, opts("View Diagnostic on Line"))

-- tmux sessionizer
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts("Tmux Sessionizer"))
