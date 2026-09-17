-- EDITOR OPTIONS
vim.o.number = true
vim.o.relativenumber = true

vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.softtabstop = 4

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.foldmethod = "indent"
vim.o.foldlevel = 99 -- start with folds open
vim.o.foldlevelstart = 99
vim.opt.foldenable = true

vim.o.clipboard = "unnamedplus" -- integrate with system clipboard
vim.opt.pumheight = 10          -- limit popup menu height
vim.o.cmdheight = 0             -- Do not show bottom line

vim.diagnostic.config({
    virtual_text = false
})


vim.o.winborder = "rounded"
