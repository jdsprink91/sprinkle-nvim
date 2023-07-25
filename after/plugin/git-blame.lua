-- need to keep this in after so git blame disable is recognized as a command
vim.keymap.set('n', '<leader>gb', "<CMD>GitBlameToggle<CR>", {})

vim.cmd("GitBlameDisable")
