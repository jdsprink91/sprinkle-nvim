return {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
        "savq/melange-nvim",
        as = "melange",
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
        keys = {
            { "<leader>gs", vim.cmd.Git }
        }
    },
    {
        'f-person/git-blame.nvim',
        keys = { { "<leader>gb", vim.cmd.GitBlameToggle }, },
        opts = {
            enabled = false
        }
    },
    "airblade/vim-gitgutter",

    -- visual help with tabs and spaces
    'lukas-reineke/indent-blankline.nvim',

    -- statusline plugin
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
        opts = {
            options = {
                theme = "melange"
            }
        }
    },

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
    "tpope/vim-unimpaired",

    -- help make myself a lil more efficient
    {
        "m4xshen/hardtime.nvim",
        dependencies = { 'MunifTanjim/nui.nvim', "nvim-lua/plenary.nvim" },
        config = true
    },

    -- OH HI MARKS
    { "chentoast/marks.nvim", config = true }
}
