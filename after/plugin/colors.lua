-- uncomment if you want cattppuccin by default
-- require('catppuccin').setup({
--     integrations = {
--         barbar = true,
--         cmp = true,
--         mason = true,
--         native_lsp = {
--             enabled = true,
--             virtual_text = {
--                 errors = { "italic" },
--                 hints = { "italic" },
--                 warnings = { "italic" },
--                 information = { "italic" },
--             },
--             underlines = {
--                 errors = { "underline" },
--                 hints = { "underline" },
--                 warnings = { "underline" },
--                 information = { "underline" },
--             },
--         },
--         telescope = true,
--         treesitter = true
--     },
--     highlight_overrides = {
--         frappe = function(frappe)
--             -- update the line numbers on the side!
--             return {
--                 LineNr = { fg = frappe.yellow }
--             }
--         end,
--         mocha = function(mocha)
--             -- update the line numbers on the side!
--             return {
--                 LineNr = { fg = mocha.yellow }
--             }
--         end,
--     },
-- })
--
-- vim.cmd.colorscheme("catppuccin-mocha")

-- uncomment if you want default to be dracula
-- vim.cmd.colorscheme("dracula")

-- uncomment if you want kanagawa as default
-- vim.cmd.colorscheme("kanagawa")

-- vim.cmd.colorscheme("nightfox")

-- melange
vim.opt.termguicolors = true
vim.cmd.colorscheme("melange")
