local dap = require("dap")

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = "codelldb",
    args = { "--port", "${port}" },

    -- On windows you may have to uncomment this:
    -- detached = false,
  },
}

local codelldb_conf = {
  name = "Launch file",
  type = "codelldb",
  request = "launch",
  program = function()
    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
  end,
  cwd = "${workspaceFolder}",
  stopOnEntry = false,
}

dap.configurations.cpp = { codelldb_conf }
dap.configurations.c = dap.configurations.cpp

local rust_conf = {
  initCommands = function()
    -- Find out where to look for the pretty printer Python module
    local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

    local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
    local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

    local commands = {}
    local file = io.open(commands_file, "r")
    if file then
      for line in file:lines() do
        table.insert(commands, line)
      end
      file:close()
    end
    table.insert(commands, 1, script_import)

    return commands
  end,
  -- ...,
}
dap.configurations.rust = { vim.tbl_deep_extend("keep", codelldb_conf, rust_conf) }
