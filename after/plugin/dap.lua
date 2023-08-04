local dap = require('dap')
local dapPython = require("dap-python")
local dapui = require('dapui')

dapPython.setup("python")

-- here, we are inserting a new selectable configuration into our debugging option table
-- this includes the information on how to look at things in a djangoproject FROM
-- the djangoproject folder
table.insert(require("dap").configurations.python, {
    type = "python",
    request = "attach",
    connect = {
        port = 8765,
        host = "localhost",
    },
    mode = "remote",
    name = "Python: Remote Django",
    cwd = vim.fn.getcwd(),
    pathMappings = {
        {
            localRoot = vim.fn.getcwd(),
            remoteRoot = "/opt/app"
        },
    },
    django = true
})

vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F6>', function() dap.disconnect() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)
vim.keymap.set('n', '<F12>', function() dap.step_out() end)
vim.keymap.set('n', '<Leader>tb', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>sb', function() dap.set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp',
    function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)
