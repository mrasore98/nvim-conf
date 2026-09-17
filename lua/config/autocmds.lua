-- AUTOCMDS

-- Open help files in right split automatically
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("help_window_right", {}),
    pattern = { "*.txt" },
    callback = function()
        if vim.o.filetype == 'help' then
            vim.cmd.wincmd("L")
        end
    end
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
})
