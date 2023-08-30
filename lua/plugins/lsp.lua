return {
    -- lsps
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },         -- Required
            { 'hrsh7th/cmp-nvim-lsp' },     -- Required
            { 'hrsh7th/cmp-buffer' },       -- Optional
            { 'hrsh7th/cmp-path' },         -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' },     -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        },
        config = function()
            local lsp = require("lsp-zero")
            local lspconfig = require("lspconfig")

            lsp.preset({})

            lsp.on_attach(function(_, bufnr)
                local opts = { buffer = bufnr }
                lsp.default_keymaps({ buffer = bufnr, omit = { "gs" } })
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

                vim.keymap.set({ 'n', 'x' }, '<leader>pf', function()
                    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
                end, opts)
            end)

            lspconfig.tailwindcss.setup({
                init_options = {
                    userLanguages = {
                        htmldjango = "html"
                    }
                }
            })

            lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

            lspconfig.pylsp.setup {
                settings = {
                    pylsp = {
                        configurationSources = { 'flake8' },
                        plugins = {
                            -- we don't care about these, we use flake8
                            pycodestyle = { enabled = false },
                            mccabe = { enabled = false },
                            pyflakes = { enabled = false },

                            -- literati related config
                            flake8 = {
                                enabled = false,
                            },
                        }
                    }
                }
            }

            lspconfig.eslint.setup {
                on_attach = function(client)
                    -- turn on that eslint is a formatting provider for the appropriate
                    -- file types
                    client.server_capabilities.documentFormattingProvider = true
                end
            }

            lsp.setup()

            -- setup using enter for autocomplete selection
            local cmp = require('cmp')
            cmp.setup({
                mapping = {
                    -- setting select to true means it will select the first item
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                },
                enabled = function()
                    -- it was getting annoying to see cmp work inside comments, this disables that
                    local in_prompt = vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt'
                    if in_prompt then -- this will disable cmp in the Telescope window (taken from the default config)
                        return false
                    end
                    local context = require("cmp.config.context")
                    return not (context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment"))
                end
            })
        end
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            -- use null ls to setup formatting and diagnostics
            local null_ls = require("null-ls")
            null_ls.setup({
                should_attach = function(bufnr)
                    -- I want to always ignore formatting / diagnostics in packages
                    -- this was breaking mypy which was annoying. Turns out, I just
                    -- it's better to not care about things we shouldn't care about
                    return not vim.api.nvim_buf_get_name(bufnr):match(".pyenv")
                end,
                debug = true,
                sources = {
                    -- diagnostics
                    null_ls.builtins.diagnostics.flake8.with({ prefer_local = true }),
                    null_ls.builtins.diagnostics.djlint.with({
                        prefer_local = true,
                        extra_args = {
                            "--profile=django",
                        }
                    }),
                    null_ls.builtins.diagnostics.mypy.with({
                        prefer_local = true,
                        extra_args = {
                            "--check-untyped-defs",
                            "--ignore-missing-imports",
                        },
                        timeout = 10000
                    }),
                    -- formatting
                    null_ls.builtins.formatting.black.with({ prefer_local = true }),
                    null_ls.builtins.formatting.isort.with({ prefer_local = true }),
                    null_ls.builtins.formatting.djlint.with({ prefer_local = true, extra_args = { "--profile=django" } }),
                    null_ls.builtins.formatting.prettier.with({ prefer_local = true })
                },
            })
        end
    },
}
