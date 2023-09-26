local dap = require("dap")

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

dap.adapters.rust_gdb = {
  type = "executable",
  command = "rust-gdb",
  name = "gdb",
}

dap.configurations.rust = {
  {
    name = "Debug Bin",
    type = "codelldb",
    request = "launch",
    program = function()
      return run_build(build_type.BIN)
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    showDisassembly = "never",
  },
  {
    name = "Debug Test",
    type = "rust_gdb",
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
    type = "rust_gdb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}
