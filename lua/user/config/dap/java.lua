-- This setting is for manual nvim-dap setting without nvim-jdtls

-- https://github.com/mfussenegger/nvim-jdtls/blob/095dc490f362adc85be66dc14bd9665ddd94413b/lua/jdtls/util.lua#L5
local function execute_command(command, callback, bufnr)
  local clients = {}
  local candidates = vim.lsp.get_active_clients({ bufnr = bufnr })
  for _, c in pairs(candidates) do
    local command_provider = c.server_capabilities.executeCommandProvider
    local commands = type(command_provider) == "table" and command_provider.commands or {}
    if vim.tbl_contains(commands, command.command) then
      table.insert(clients, c)
    end
  end
  local num_clients = vim.tbl_count(clients)
  if num_clients == 0 then
    if bufnr then
      -- User could've switched buffer to non-java file, try all clients
      return execute_command(command, callback, nil)
    else
      vim.notify("No LSP client found that supports " .. command.command, vim.log.levels.ERROR)
      return
    end
  end

  if num_clients > 1 then
    vim.notify(
      "Multiple LSP clients found that support "
        .. command.command
        .. " you should have at most one JDTLS server running",
      vim.log.levels.WARN
    )
  end

  local co
  if not callback then
    co = coroutine.running()
    if co then
      callback = function(err, resp)
        coroutine.resume(co, err, resp)
      end
    end
  end
  clients[1].request("workspace/executeCommand", command, callback, bufnr)
  if co then
    return coroutine.yield()
  end
end

local dap = require("dap")
dap.adapters.java = function(callback, config)
  local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
  local jdtls = vim.tbl_filter(function(client)
    return client.name == "jdtls" and client.config and client.config.root_dir == config.cwd
  end, get_clients())[1]
  local bufnr = vim.lsp.get_buffers_by_client_id(jdtls and jdtls.id)[1] or vim.api.nvim_get_current_buf()
  execute_command({ command = "vscode.java.startDebugSession" }, function(err0, port)
    assert(not err0, vim.inspect(err0))

    callback({
      type = "server",
      host = "127.0.0.1",
      port = port,
    })
  end, bufnr)
end

dap.configurations.java = {
  -- TODO: Add  configuration
}
