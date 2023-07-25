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
