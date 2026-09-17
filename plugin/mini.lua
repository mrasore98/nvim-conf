-- APPEARANCE
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()
require("mini.statusline").setup()
require("mini.tabline").setup({})


-- FILES
require("mini.files").setup({ window = { preview = true } })
vim.keymap.set('n', '<leader>e', MiniFiles.open, { desc = "Mini Files" })

-- UNCATEGORIZED
require("mini.ai").setup()
require("mini.pairs").setup()
require("mini.surround").setup()


require("mini.completion").setup()
-- Disable completion for pickers
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("disable_picker_completion", { clear = true }),
    pattern = "snacks_picker_input",
    callback = function()
        vim.b.minicompletion_disable = true
    end,
})
