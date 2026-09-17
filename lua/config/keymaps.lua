-- KEYMAP CONFIG
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>qq', ':qall<CR>', { desc = "Quit" })
vim.keymap.set('n', '<leader>rr', ':restart<CR>', { desc = "Restart" })
-- window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
--buffer navigation
vim.keymap.set('n', '<S-h>', ':bp<CR>', { desc = "Next buffer" })
vim.keymap.set('n', '<S-l>', ':bn<CR>', { desc = "Previous buffer" })
vim.keymap.set('n', '<C-d>', '<C-d>zz') -- Move down, centered
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- Move up, centered
-- diagnostics
vim.keymap.set('n', '<leader>ds', vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set('n', '<leader>dt', function()
    local config = vim.diagnostic.config()
    vim.diagnostic.config({ virtual_text = not config.virtual_text })
end, { desc = "Toggle inline diagnostics" })
-- LSP and formating
vim.keymap.set('n', 'lf', vim.lsp.buf.format, { desc = "Format buffer" })
vim.keymap.set({ 'n', 'i' }, '<C-s>', function()
    vim.lsp.buf.format()
    vim.cmd('write')
end, { desc = "Format and save" })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = "Code rename" })
