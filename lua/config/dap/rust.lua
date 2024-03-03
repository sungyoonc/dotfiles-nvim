local dap = require("dap")

if dap.adapters.codelldb == nil then
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = "codelldb",
      args = { "--port", "${port}" },
    },
  }

  if vim.fn.has("win32") == 1 then
    dap.adapters.codelldb.executable.detached = false
  end
end

local build_type = {
  TEST = "cargo build --tests -q --message-format=json",
  BIN = "cargo build -q --message-format=json",
}

local function run_build(type)
  local lines = vim.fn.systemlist(type)
  local output = table.concat(lines, "\n")
  local filename = output:match('^.*"executable":"(.*)",.*\n.*,"success":true}$')

  if filename == nil then
    return error("Failed to build cargo project")
  end

  return filename
end

dap.configurations.rust = {
  {
    name = "Debug Bin",
    type = "codelldb",
    request = "launch",
    program = function()
      return run_build(build_type.BIN)
    end,
    arg = function()
      local args = vim.fn.input("Arguments: ")
      return vim.split(args, " ", { trimempty = true })
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    showDisassembly = "never",
  },
  {
    name = "Debug Test",
    type = "codelldb",
    request = "launch",
    program = function()
      return run_build(build_type.TEST)
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    showDisassembly = "never",
  },
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}
