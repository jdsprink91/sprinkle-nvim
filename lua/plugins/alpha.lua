return {
    {
        "goolord/alpha-nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            -- Set header
            dashboard.section.header.val = {
                "    __________________   __________________    ",
                ".-/|                  \\ /                  |\\-.",
                "||||                   |                   ||||",
                "||||                   |       ~~*~~       ||||",
                "||||    --==*==--      |                   ||||",
                "||||                   |                   ||||",
                "||||                   |                   ||||",
                "||||                   |     Literati!     ||||",
                "||||                   |                   ||||",
                "||||                   |                   ||||",
                "||||                   |                   ||||",
                "||||                   |                   ||||",
                "||||__________________ | __________________||||",
                "||/===================\\|/===================\\||",
                "`--------------------~___~-------------------''",
            }

            dashboard.section.buttons.val = {
                dashboard.button("f", "📁  > Find File", ":Telescope git_files hidden=true<CR>"),
                dashboard.button("s", "🔎  > Search", ":Telescope live_grep<cr>"),
                dashboard.button("l", "📌  > Load Last Session", ":SessionManager load_current_dir_session<CR>"),
                dashboard.button("u", "🔌  > Update Plugins", ":Lazy sync<CR>"),
                dashboard.button("q", "🛑  > Quit Neovim", ":qa<CR>"),
            }

            -- Send config to alpha
            alpha.setup(dashboard.opts)
        end
    },
}
