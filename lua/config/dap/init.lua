-- Keybinds
local keymap = vim.keymap.set
keymap("n", "<F5>", function()
  require("dap").continue()
end, { desc = "Continue Debug" })
keymap("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "Step Over" })
keymap("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "Step Into" })
keymap("n", "<F12>", function()
  require("dap").step_out()
end, { desc = "Step Out" })
keymap("n", "<Leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
keymap("n", "<Leader>dB", function()
  require("dap").set_breakpoint()
end, { desc = "Set Breakpoint" })
keymap("n", "<Leader>dlp", function()
  require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "Set Log point" })
keymap("n", "<Leader>dr", function()
  require("dap").repl.open()
end, { desc = "Open Debug REPL" })

-- Load dap
local dap, dapui = require("dap"), require("dapui")
dapui.setup({})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require("config.dap.cpp")
require("config.dap.rust")
require("config.dap.python")
