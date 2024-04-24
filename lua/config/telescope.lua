local telescope = require("telescope")

telescope.load_extension("media_files")

local actions = require("telescope.actions")

telescope.setup({
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
  -- pickers = {
  -- Default configuration for builtin pickers goes here:
  -- picker_name = {
  --   picker_config_key = value,
  --   ...
  -- }
  -- Now the picker_config_key will be applied every time you call this
  -- builtin picker
  -- },
  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "rg", -- find command (defaults to `fd`)
    },
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  },
})

-- Telescope keymaps --
local keymap = vim.keymap.set

---@param desc string
local function opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

local builtin = require("telescope.builtin")
local utils = require("telescope.utils")
keymap("n", "<C-p>", function()
  local result, _ = pcall(builtin.git_files)
  if not result then
    vim.notify("Telescope: no git found.")
    builtin.find_files() -- Fallback to find files
  end
end, opts("Find Git Files"))

keymap("n", "<leader>pf", builtin.find_files, opts("Find Files (cwd)"))
keymap("n", "<leader>pF", function()
  builtin.find_files({
    cwd = utils.buffer_dir(),
  })
end, opts("Find Files (directory of current file)"))

keymap("n", "<leader>ps", builtin.live_grep, opts("Live Grep"))

keymap("n", "<leader>pS", function()
  vim.ui.input({ prompt = "Grep Search", kind = "telescope_grep_string" }, function(input)
    if input == nil then
      return
    end

    builtin.grep_string({
      search = input,
    })
  end)
end, opts("Grep String"))

keymap("n", "<leader>ph", builtin.help_tags, opts("View Help Tags"))
