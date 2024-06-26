local dap = require("dap")

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

local codelldb_launch = {
  name = "Launch file",
  type = "codelldb",
  request = "launch",
  program = function()
    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
  end,
  cwd = "${workspaceFolder}",
  stopOnEntry = false,
}

local codelldb_attach = {
  name = "Attach",
  type = "codelldb",
  request = "attach",
  pid = require("dap.utils").pick_process,
  args = {},
}

dap.configurations.cpp = { codelldb_launch, codelldb_attach }
dap.configurations.c = dap.configurations.cpp
