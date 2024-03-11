local zen_mode = require("zen-mode")
zen_mode.setup()

vim.keymap.set("n", "<leader>zz", function()
  local window_options = {
    number = true,
    relativenumber = true,
  }

  local old_options = {}
  local new_options = {}
  for k, _ in pairs(window_options) do
    old_options[k] = vim.api.nvim_get_option_value(k, {})
  end

  zen_mode.toggle({
    window = {
      options = window_options,
    },
    on_open = function()
      for k, _ in pairs(window_options) do
        new_options[k] = vim.api.nvim_get_option_value(k, {})
      end
    end,
    on_close = function()
      for k, v in pairs(old_options) do
        local current_value = vim.api.nvim_get_option_value(k, {})
        if current_value == new_options[k] then
          vim.api.nvim_set_option_value(k, v, {})
        end
      end
    end,
  })
end, { desc = "Toggle Zen Mode" })

vim.keymap.set("n", "<leader>zZ", function()
  local window_options = {
    number = false,
    relativenumber = false,
    colorcolumn = "0",
  }

  local old_options = {}
  local new_options = {}
  for k, _ in pairs(window_options) do
    old_options[k] = vim.api.nvim_get_option_value(k, {})
  end

  zen_mode.toggle({
    window = {
      width = 110,
      options = window_options,
    },
    on_open = function()
      for k, _ in pairs(window_options) do
        new_options[k] = vim.api.nvim_get_option_value(k, {})
      end
    end,
    on_close = function()
      for k, v in pairs(old_options) do
        local current_value = vim.api.nvim_get_option_value(k, {})
        if current_value == new_options[k] then
          vim.api.nvim_set_option_value(k, v, {})
        end
      end
    end,
  })
end, { desc = "Toggle Deep Zen Mode" })

-- Tmux like pane(window in neovim) zoom
vim.keymap.set("n", "<c-w>z", function()
  -- If there is only one window, don't zoom
  local is_open = require("zen-mode.view").is_open()
  if not is_open then
    local windows = vim.api.nvim_tabpage_list_wins(0)
    local real_windows = vim.tbl_filter(function(item)
      return "" == vim.api.nvim_win_get_config(item).relative
    end, windows)
    if #real_windows < 2 then
      return
    end
  end

  local config = require("zen-mode.config")
  local plugins_options = vim.tbl_extend("force", config.options.plugins.options, {
    showcmd = true,
    ruler = true,
    laststatus = 3,
  })

  local current_statusline = vim.opt.statusline:get()
  zen_mode.toggle({
    window = {
      width = 1,
    },
    plugins = {
      options = plugins_options,
    },
    on_open = function()
      vim.wo.statusline = "%<%f*Z %h%w%m%r%=%-14.(%l,%c%V%) %P"
    end,
    on_close = function()
      vim.wo.statusline = current_statusline
    end,
  })
end, { desc = "Toggle Zoom" })
