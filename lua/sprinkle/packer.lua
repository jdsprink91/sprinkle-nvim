local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use { 'wbthomason/packer.nvim' }

    -- I think this is a bunch of helper functions
    use { 'nvim-lua/plenary.nvim' }

    -- the lil icons that show up everywhere
    use { 'nvim-tree/nvim-web-devicons' }

    -- telescope and telescope accessories
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }

    -- theme
    use { "savq/melange-nvim", as = "melange", config = function()
        vim.opt.termguicolors = true
        vim.cmd.colorscheme("melange")
    end }

    -- syntax highlighting
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/nvim-treesitter-context' }

    -- show me my undo history
    use {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
        end
    }

    -- git
    use {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
        end
    }
    use { 'f-person/git-blame.nvim' }

    -- lsps
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
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
    }

    -- for mah formatters that aren't supported
    use { 'jose-elias-alvarez/null-ls.nvim' }

    -- visual help with tabs and spaces
    use {
        'Yggdroot/indentLine',
        config = function()
            vim.g.indentLine_fileTypeExclude = {
                "alpha",
            }
        end
    }

    -- statusline plugin
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require("lualine").setup({ options = { theme = 'melange' } })
        end
    }

    -- that sweet sweet surround plugin
    use {
        'tpope/vim-surround',
        config = function()
            vim.g.surround_115 = "**\r**"  -- 115 is the ASCII code for 's'
            vim.g.surround_47 = "/* \r */" -- 47 is /
        end
    }

    -- that sweet sweet commenting help
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- that sweet sweet autopair
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    -- entering in the ART ZONE
    use {
        "goolord/alpha-nvim",
        requires = { 'nvim-tree/nvim-web-devicons' }
    }

    -- session management
    use {
        "Shatur/neovim-session-manager",
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            local config = require('session_manager.config')

            -- don't automatically load up previous session
            -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
            require('session_manager').setup({
                autoload_mode = config.AutoloadMode.Disabled,
            })
        end
    }

    -- gimme dat debugger
    use { "mfussenegger/nvim-dap" }
    use { "mfussenegger/nvim-dap-python", requires = { "mfussenegger/nvim-dap" } }
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

    -- helps with repeating thing
    use { "tpope/vim-repeat" }

    -- taking a beeg leap here
    use {
        "ggandor/leap.nvim",
        -- one two three repeater!
        requires = { "tpope/vim-repeat" },
        config = function()
            require("leap").add_default_mappings()
        end
    }

    -- gives us some keybindings that help with navigation
    use {
        'tpope/vim-unimpaired'
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
