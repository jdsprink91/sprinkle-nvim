return {
    -- telescope and telescope accessories
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            local telescope = require('telescope')
            local action_state = require('telescope.actions.state')
            local builtin = require('telescope.builtin')
            local actions = require('telescope.actions')
            telescope.setup {
                defaults = {
                    file_ignore_patterns = { ".git/" }
                },
                pickers = {
                    find_files = {
                        hidden = true
                    },
                    git_files = {
                        hidden = true
                    },
                    oldfiles = {
                        hidden = true
                    },
                }
            }
            telescope.load_extension("file_browser")
            local m = {}
            m.buffers = function(opts)
                opts = opts or {}
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
                builtin.buffers(opts)
            end

            -- all the key maps
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
            vim.keymap.set('n', '<leader>of', builtin.oldfiles, {})
            vim.keymap.set('n', '<leader>ps', builtin.grep_string, {})
            vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', m.buffers, {})
            vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
        end
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        keys = {
            {"<leader>hd", ":Telescope file_browser<CR>"},
            {"<leader>cd", ":Telescope file_browser path=%:p:h select_buffer=true<CR>"}
        }
    },

}
