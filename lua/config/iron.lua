local iron = require("iron.core")
local view = require("iron.view")

iron.setup {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      python = {
        -- Can be a table or a function that
        -- returns a table (see below)
        command = {"python"}
      },
    },
    -- How the repl window will be displayed
    -- See below for more information
    repl_open_cmd = require('iron.view').right("40%"),
  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    send_motion = "<leader>rsc",
    visual_send = "<leader>rsc",
    send_file = "<leader>rsf",
    send_line = "<leader>rsl",
    send_until_cursor = "<leader>rsu",
    send_mark = "<leader>rsm",
    mark_motion = "<leader>rmc",
    mark_visual = "<leader>rmc",
    remove_mark = "<leader>rmd",
    cr = "<leader>rs<CR>",
    interrupt = "<leader>rs<space>",
    exit = "<leader>rsq",
    clear = "<leader>rcl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<leader>rs', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<leader>rr', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<leader>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<leader>rh', '<cmd>IronHide<cr>')

