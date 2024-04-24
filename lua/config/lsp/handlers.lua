local M = {}

-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- toggle virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlight then
    local lsp_doc_highlight_augroup = vim.api.nvim_create_augroup("lsp_document_highlight", {})
    vim.api.nvim_create_autocmd("CursorHold", {
      group = lsp_doc_highlight_augroup,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = lsp_doc_highlight_augroup,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end
end

function M.lsp_keymaps(bufnr)
  ---@param desc string
  local function opts(desc)
    return { noremap = true, silent = true, buffer = bufnr, desc = desc }
  end
  local keymap = vim.keymap.set
  keymap("n", "gd", vim.cmd.LspInfo, opts("Lsp Info"))
  keymap("n", "gd", vim.lsp.buf.definition, opts("Goto Defenition"))
  keymap("n", "gr", vim.lsp.buf.references, opts("References"))
  keymap("n", "gD", vim.lsp.buf.declaration, opts("Goto Declaration"))
  keymap("n", "gI", vim.lsp.buf.implementation, opts("Goto Implementation"))
  keymap("n", "gy", vim.lsp.buf.type_definition, opts("Goto T[y]pe Definition"))
  keymap("n", "K", vim.lsp.buf.hover, opts("Hover"))
  keymap("n", "gK", vim.lsp.buf.signature_help, opts("Signature Help"))
  keymap("i", "<C-k>", vim.lsp.buf.signature_help, opts("Signature Help"))
  keymap({ "n", "v" }, "<leader>lca", vim.lsp.buf.code_action, opts("Code Action"))
  keymap("n", "<leader>lcA", function()
    vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostic = {} } })
  end, opts("Source Action"))
  keymap("n", "<leader>lrn", vim.lsp.buf.rename, opts("Rename"))
  keymap("n", "<leader>li", function()
    if vim.lsp.inlay_hint.is_enabled(0) then
      vim.lsp.inlay_hint.enable(false)
    else
      vim.lsp.inlay_hint.enable(true)
    end
  end, opts("Toggle Inlay Hint"))
end

M.on_attach = function(client, bufnr)
  -- Load server-specific language server capabilities settings
  local conf_ok, conf_capa = pcall(require, "config.lsp.server_settings." .. client.name)
  if conf_ok then
    client.server_capabilities = vim.tbl_extend("force", client.server_capabilities, conf_capa)
  end

  -- Enable inlay hints
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end
-- https://github.com/neovim/nvim-lspconfig#suggested-configuration
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client == nil then
      print("Failed to get LSP client")
      return
    end

    M.lsp_keymaps(bufnr)
    lsp_highlight_document(client)

    -- use telescope lsp pickers
    local status_ok, builtin = pcall(require, "telescope.builtin")
    if status_ok then
      vim.lsp.handlers["textDocument/references"] = builtin.lsp_references
      vim.lsp.handlers["textDocument/definition"] = builtin.lsp_definitions
    end
  end,
})

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  M.capabilities = cmp_nvim_lsp.default_capabilities()
end

return M
