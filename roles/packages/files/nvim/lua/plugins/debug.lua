local dapui = require("dapui")
local dap = require("dap")

require('dap-go').setup()
dapui.setup({
  mappings = {
    edit = "e",
    expand = "<CR>",
    open = "o",
    remove = "d",
    repl = "r",
    toggle = "t",
  },
})

dap.listeners.before.attach.dapui_config = function()
  vim.opt.mouse = "n"
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  vim.opt.mouse = "n"
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  vim.opt.mouse = nil
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  vim.opt.mouse = nil
  dapui.close()
end
