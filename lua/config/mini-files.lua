require("mini.files").setup({
  windows = {
    preview = true,
    width_focus = 30,
    width_preview = 30,
  },
  options = {
    -- Whether to use for editing directories
    -- Disabled by default in LazyVim because neo-tree is used for that
    use_as_default_explorer = false,
  },
})

---@param from string
---@param to string
local function on_rename(from, to)
  local clients = vim.lsp.get_clients()
  for _, client in ipairs(clients) do
    if client.supports_method("workspace/willRenameFiles") then
      ---@diagnostic disable-next-line: invisible
      local resp = client.request_sync("workspace/willRenameFiles", {
        files = {
          {
            oldUri = vim.uri_from_fname(from),
            newUri = vim.uri_from_fname(to),
          },
        },
      }, 1000, 0)
      if resp and resp.result ~= nil then
        vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
      end
    end
  end
end

local show_dotfiles = true
local filter_show = function()
  return true
end
local filter_hide = function(fs_entry)
  return not vim.startswith(fs_entry.name, ".")
end

local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  local new_filter = show_dotfiles and filter_show or filter_hide
  require("mini.files").refresh({ content = { filter = new_filter } })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id
    vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle dotfiles visibility" })
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesActionRename",
  callback = function(event)
    on_rename(event.data.from, event.data.to)
  end,
})
