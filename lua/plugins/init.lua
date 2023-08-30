return {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',

    -- theme
    {
        "savq/melange-nvim",
        as = "melange",
        config = function()
            vim.opt.termguicolors = true
            vim.cmd.colorscheme("melange")
            -- need to do this to make the first autojump of
            -- leap vim behave as expected
            local bg = vim.opt.background:get()
            local palette = require('melange/palettes/' .. bg)
            vim.api.nvim_set_hl(0, 'Cursor', { bg = palette.b.red, fg = palette.a.bg })
        end
    },

    -- syntax highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",

        }
    },
    'nvim-treesitter/nvim-treesitter-context',

    -- show me my undo history
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', "<leader>u", vim.cmd.UndotreeToggle)
        end
    },

    -- git
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
        end
    },
    'f-person/git-blame.nvim',
    'airblade/vim-gitgutter',

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
        }
    },

    -- for mah formatters that aren't supported
    'jose-elias-alvarez/null-ls.nvim',

    -- visual help with tabs and spaces
    {
        'Yggdroot/indentLine',
        config = function()
            vim.g.indentLine_fileTypeExclude = {
                "alpha",
            }
        end
    },

    -- statusline plugin
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function()
            require("lualine").setup({ options = { theme = 'melange' } })
        end
    },

    -- that sweet sweet surround plugin
    {
        'tpope/vim-surround',
        config = function()
            vim.g.surround_115 = "**\r**"  -- 115 is the ASCII code for 's'
            vim.g.surround_47 = "/* \r */" -- 47 is /
        end
    },

    -- that sweet sweet commenting help
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    -- that sweet sweet autopair
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },

    -- entering in the ART ZONE
    {
        "goolord/alpha-nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    -- session management
    {
        "Shatur/neovim-session-manager",
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local config = require('session_manager.config')

            -- don't automatically load up previous session
            -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
            require('session_manager').setup({
                autoload_mode = config.AutoloadMode.Disabled,
            })
        end
    },

    -- gimme dat debugger
    "mfussenegger/nvim-dap",
    { "mfussenegger/nvim-dap-python", dependencies = { "mfussenegger/nvim-dap" } },
    { "rcarriga/nvim-dap-ui",         dependencies = { "mfussenegger/nvim-dap" } },

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

    -- gives us some keybindings that help with navigation
    'tpope/vim-unimpaired',

    -- help make myself a lil more efficient
    {
        "m4xshen/hardtime.nvim",
        dependencies = { 'MunifTanjim/nui.nvim', "nvim-lua/plenary.nvim" },
        config = function()
            require('hardtime').setup()
        end
    },

}
