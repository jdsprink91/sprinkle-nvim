local telescope = require("telescope")
local builtin = require('telescope.builtin')
local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')

-- setup telescope
telescope.setup {
    defaults = {
        file_ignore_patterns = { ".git/" }
    }
}

vim.keymap.set('n', '<leader>ff', "<CMD>Telescope find_files hidden=true<CR>", {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>gf', "<CMD>Telescope git_files hidden=true<CR>", {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- FILE BROWSER PLUGIN
telescope.load_extension "file_browser"

-- vim.keymap.set("n", "<leader>fb", function() telescope.extensions.file_browser.file_browser() end, { noremap = true})
-- open file_browser with the path of the current buffer
vim.api.nvim_set_keymap(
    "n",
    "<space>hd",
    ":Telescope file_browser <CR>",
    { noremap = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<space>cd",
    ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
    { noremap = true }
)

-- SHOW ME MAH BUFFERS
local m = {}
m.buffers = function(opts)
    opts = opts or {}
    opts.previewer = false
    -- opts.sort_lastused = true
    -- opts.show_all_buffers = true
    -- opts.shorten_path = false
    opts.attach_mappings = function(prompt_bufnr, map)
        local d = {}
        d.delete_buf = function()
            local current_picker = action_state.get_current_picker(prompt_bufnr)
            local multi_selections = current_picker:get_multi_selection()

            if next(multi_selections) == nil then
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.api.nvim_buf_delete(selection.bufnr, { force = true })
            else
                actions.close(prompt_bufnr)
                for _, selection in ipairs(multi_selections) do
                    vim.api.nvim_buf_delete(selection.bufnr, { force = true })
                end
            end
        end
        map('i', '<C-d>', d.delete_buf)
        map('n', '<C-d>', d.delete_buf)
        return true
    end
    -- we can't have the nice ui here because C-d moves file previewer
    builtin.buffers(require('telescope.themes').get_dropdown(opts))
end

vim.keymap.set('n', '<leader>fb', m.buffers, {})
