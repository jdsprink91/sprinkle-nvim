-- SO LAZY
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    -- bootstrap lazy.nvim
    -- stylua: ignore
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- I guess lazy vim needs this?
vim.g.mapleader = " "

-- setup plugins
require('lazy').setup({
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
        "oxfist/night-owl.nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            vim.cmd.colorscheme("night-owl")
        end,
    },
    {
        'mbbill/undotree',
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle }
        }
    },

    -- git plugins
    {
        'tpope/vim-fugitive',
        lazy = false,
        keys = {
            { "<leader>gs", vim.cmd.Git }
        }
    },
    'f-person/git-blame.nvim',
    'airblade/vim-gitgutter',

    -- visual help with tabs and spaces
    {
        'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
        opts = {
            indent = {
                char = "¦"
            },
            exclude = {
                filetypes = {
                    "alpha"
                }
            }
        }
    },

    -- statusline plugin
    'nvim-lualine/lualine.nvim',

    -- that sweet sweet surround plugin
    {
        'tpope/vim-surround',
        config = function()
            vim.g.surround_115 = "**\r**"  -- 115 is the ASCII code for 's'
            vim.g.surround_47 = "/* \r */" -- 47 is /
        end
    },

    { "numToStr/Comment.nvim", config = true, },
    { "windwp/nvim-autopairs", config = true },

    -- session management
    {
        "Shatur/neovim-session-manager",
        config = function()
            local config = require('session_manager.config')

            -- don't automatically load up previous session
            -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
            require('session_manager').setup({
                autoload_mode = config.AutoloadMode.Disabled,
            })
        end
    },


    -- helps with repeating thing
    "tpope/vim-repeat",

    -- taking a beeg leap here
    {
        "ggandor/leap.nvim",
        -- one two three repeater!
        dependencies = { "tpope/vim-repeat" },
        config = function()
            local leap = require('leap')
            leap.add_default_mappings()
            leap.opts.highlight_unlabeled_phase_one_targets = true
        end
    },

    -- autodetecting of tab widths and such
    "tpope/vim-sleuth",

    -- schema store for json and yaml
    "b0o/schemastore.nvim",

    -- lsps
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
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
            { 'hrsh7th/cmp-cmdline' },      -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' },     -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        },
    },
    'nvimtools/none-ls.nvim',

    -- treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        opts = {
            -- A list of parser names, or "all" (the four listed parsers should always be installed)
            ensure_installed = { "astro", "javascript", "typescript", "lua", "vim", "python", "html", "htmldjango", "css",
                "jsdoc", "markdown", "yaml", "tsx", "toml", "json" },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            highlight = {
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
            textobjects = {
                -- NOTE: select only works in visual mode
                -- see more at https://github.com/nvim-treesitter/nvim-treesitter-textobjects
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = {
                            query = "@function.outer",
                            desc =
                            "Select function including the function definition"
                        },
                        ["if"] = { query = "@function.inner", desc = "Select the inner part of a function" },
                        ["ac"] = { query = "@class.outer", desc = "Select class including class definition" },
                        ["ic"] = { query = "@class.inner", desc = "Select the inner part of a class" }
                    }
                }
            }
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
    },
    'nvim-treesitter/nvim-treesitter-context',

    -- telescope and telescope accessories
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
    },

    -- oil, not vinegar
    {
        'stevearc/oil.nvim',
        opts = {},
    },

    -- dap and dap accessories
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "mfussenegger/nvim-dap-python",
            { "mxsdev/nvim-dap-vscode-js", tag = "v1.1.0" },
            {
                "microsoft/vscode-js-debug",
                tag = "v1.74.1",
                build = "npm ci --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
            },
        },
    },

    -- alpha
    "goolord/alpha-nvim",
}, {})

-- mr worldwide
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.hidden = true

vim.g.python3_host_prog = '/Users/jasonsprinkle/.pyenv/versions/py3nvim/bin/python'

vim.opt.foldmethod = "indent"
vim.opt.foldenable = false

-- some keymaps
vim.keymap.set("n", "[w", "<C-w>W")
vim.keymap.set("n", "]w", "<C-w>w")
vim.keymap.set("n", "[q", ":cprev<CR>")
vim.keymap.set("n", "]q", ":cnext<CR>")

-- if we're in a django project, always set these html files to be htmldjango
vim.api.nvim_create_autocmd({
    "BufNewFile",
    "BufRead"
}, {
    pattern = { "*.html" },
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        -- if this is an html file in a django project, then we should
        -- automatically set the filetype to such
        if vim.api.nvim_buf_get_name(buf):match("djangoproject") then
            vim.api.nvim_buf_set_option(buf, "filetype", "htmldjango")
        end
    end
})

vim.opt.termguicolors = true


-- LSPs
local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
local schemastore = require("schemastore")

lsp_zero.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr }
    lsp_zero.default_keymaps({ buffer = bufnr, omit = { "gs" } })
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    vim.keymap.set({ 'n', 'x' }, '<leader>pf', function()
        vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
    end, opts)
end)

mason.setup {}
mason_lspconfig.setup {
    ensure_installed = { "astro", "cssls", "html", "eslint", "jsonls", "lua_ls", "pylsp", "tailwindcss",
        "tsserver", "yamlls" },
    handlers = {
        lsp_zero.default_setup,
        cssls = function()
            lspconfig.cssls.setup {
                capabilities = capabilities
            }
        end,
        html = function()
            lspconfig.html.setup {
                capabilities = capabilities,
                filetypes = { "html", "htmldjango" },
                init_options = {
                    provideFormatter = false
                }
            }
        end,
        eslint = function()
            lspconfig.eslint.setup {
                on_attach = function(client)
                    -- turn on that eslint is a formatting provider for the appropriate
                    -- file types
                    client.server_capabilities.documentFormattingProvider = true
                end
            }
        end,
        jsonls = function()
            lspconfig.jsonls.setup {
                capabilities = capabilities,
                settings = {
                    json = {
                        validate = {
                            enable = true
                        },
                        schemas = schemastore.json.schemas(),
                    }
                }
            }
        end,
        lua_ls = function()
            lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())
        end,
        pylsp = function()
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
                                enabled = true,
                            },
                            isort = {
                                enabled = true,
                            },
                            black = {
                                enabled = true
                            },
                            pylsp_mypy = {
                                enabled = true,
                            }
                        }
                    }
                }
            }
        end,
        tailwindcss = function()
            lspconfig.tailwindcss.setup {
                init_options = {
                    userLanguages = {
                        htmldjango = "html"
                    },
                }
            }
        end,
        tsserver = function()
            lspconfig.tsserver.setup {}
        end,
        yamlls = function()
            lspconfig.yamlls.setup {
                capabilities = capabilities,
                settings = {
                    yaml = {
                        format = {
                            enable = true,
                        },
                        validate = true,
                        hover = true,
                        completion = true,
                        schemaStore = {
                            url = "",
                            enable = false,
                        },
                        schemas = schemastore.yaml.schemas(),
                    },
                },
            }
        end
    }

}

-- setup using enter for autocomplete selection
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()
cmp.setup({
    formatting = lsp_zero.cmp_format(),
    mapping = {
        -- setting select to true means it will select the first item
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp_action.tab_complete(),
        ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
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
-- `/` cmdline setup.
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        {
            name = 'cmdline',
            option = {
                ignore_cmds = { 'Man', '!', 'G' }
            }
        }
    })
})

-- null ls setup
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        -- diagnostics
        null_ls.builtins.diagnostics.djlint.with({
            prefer_local = true,
            extra_args = {
                "--profile=django",
            }
        }),
        null_ls.builtins.formatting.djlint.with({ prefer_local = true, extra_args = { "--profile=django" } }),
        null_ls.builtins.formatting.prettier.with({ prefer_local = true })
    },
})

-- telescope
local telescope = require('telescope')
local builtin = require('telescope.builtin')
telescope.setup {
    defaults = {
        file_ignore_patterns = { ".git/" },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        git_files = {
            hidden = true
        },
        oldfiles = {
            hidden = true
        },
    }
}
-- finding files with no previewer
local dropdown_theme_no_previewer = require('telescope.themes').get_dropdown({ previewer = false })
vim.keymap.set('n', '<leader>ff', function() builtin.find_files(dropdown_theme_no_previewer) end, {})
vim.keymap.set('n', '<leader>gf', function() builtin.git_files(dropdown_theme_no_previewer) end, {})
vim.keymap.set('n', '<leader>fb', function() builtin.buffers(dropdown_theme_no_previewer) end, {})

-- these things should get a previewer
local dropdown_theme = require('telescope.themes').get_dropdown()
vim.keymap.set('n', '<leader>lg', function() builtin.live_grep(dropdown_theme) end, {})
vim.keymap.set('n', '<leader>fr', function() builtin.lsp_references(dropdown_theme) end, {})
vim.keymap.set('n', '<leader>km', function() builtin.keymaps(dropdown_theme) end, {})

-- DAP
local dap = require('dap')
local dapPython = require("dap-python")

dapPython.setup("python")

-- here, we are inserting a new selectable configuration into our debugging option table
-- this includes the information on how to look at things in a djangoproject FROM
-- the djangoproject folder
table.insert(dap.configurations.python, {
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

-- javascript dap
-- https://github.com/mxsdev/nvim-dap-vscode-js/issues/42#issuecomment-1519068066
-- shout out to this dude who get things setup with lazy vim
require('dap-vscode-js').setup({
    debugger_path = vim.fn.stdpath('data') .. '/lazy/vscode-js-debug',
    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})
for _, language in ipairs({ 'typescript', 'javascript' }) do
    dap.configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Tests",
            -- trace = true, -- include debugger info
            runtimeExecutable = "node",
            runtimeArgs = function()
                local args_string = vim.fn.input("Arguments: ")
                local baseArgs = {
                    "./node_modules/jest/bin/jest.js",
                    "--runInBand",
                    args_string
                }

                return baseArgs
            end,
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
        }
    }
end

vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F6>', function() dap.disconnect() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)
vim.keymap.set('n', '<F12>', function() dap.step_out() end)
vim.keymap.set('n', '<Leader>tb', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>sb', function() dap.set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp',
    function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)

-- dap virtual text
local dapVirtualText = require("nvim-dap-virtual-text")
dapVirtualText.setup()

-- dap ui
local dapui = require("dapui")
dapui.setup()
vim.keymap.set('n', '<leader>do', function() dapui.open() end)
vim.keymap.set('n', '<leader>dc', function() dapui.close() end)

-- alpha
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
    " ",
    "(`-').-> _  (`-')   (`-')   _     <-. (`-')_ <-.(`-')          (`-')  _      (`-')  _     <-. (`-')",
    "( OO)_   \\-.(OO )<-.(OO )  (_)       \\( OO) ) __( OO)   <-.    ( OO).-/     _(OO ) (_)       \\(OO )_",
    "(_)--\\_)  _.'    \\,------,) ,-(`-'),--./ ,--/ '-'. ,--.,--. )  (,------.,--.(_/,-.\\ ,-(`-'),--./  ,-.)",
    "/    _ / (_...--''|   /`. ' | ( OO)|   \\ |  | |  .'   /|  (`-') |  .---'\\   \\ / (_/ | ( OO)|   `.'   |",
    "\\_..`--. |  |_.' ||  |_.' | |  |  )|  . '|  |)|      /)|  |OO )(|  '--.  \\   /   /  |  |  )|  |'.'|  |",
    ".-._)   \\|  .___.'|  .   .'(|  |_/ |  |\\    | |  .   '(|  '__ | |  .--' _ \\     /_)(|  |_/ |  |   |  |",
    "\\       /|  |     |  |\\  \\  |  |'->|  | \\   | |  |\\   \\|     |' |  `---.\\-'\\   /    |  |'->|  |   |  |",
    " `-----' `--'     `--' '--' `--'   `--'  `--' `--' '--'`-----'  `------'    `-'     `--'   `--'   `--'",
}

dashboard.section.buttons.val = {
    dashboard.button("o", "📁  > Open Oil", "<cmd>Oil<cr>"),
    dashboard.button("g", "🔎  > Grep Search", ":Telescope live_grep theme=dropdown<cr>"),
    dashboard.button("l", "📌  > Load Last Session", ":SessionManager load_current_dir_session<CR>"),
    dashboard.button("s", "🔌  > Sync Plugins", ":Lazy sync<CR>"),
    dashboard.button("q", "🛑  > Quit Neovim", ":qa<CR>"),
}

-- Send config to alpha
alpha.setup(dashboard.opts)

-- git blame
vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
local gitblame = require("gitblame")

-- lualine
local lualine = require("lualine")
lualine.setup {
    options = {
        globalstatus = true
    },
    sections = {
        lualine_x = {
            { gitblame.get_current_blame_text, cond = gitblame.is_blame_text_available },
            'encoding', 'fileformat', 'filetype'
        }
    }
}

-- oil
require('oil').setup({
    view_options = {
        show_hidden = true
    }
})
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
