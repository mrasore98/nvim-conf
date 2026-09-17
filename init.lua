require("vim._core.ui2").enable({})

vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.nvim" },                                 -- the workhorse
    { src = "https://github.com/folke/snacks.nvim" },                                   -- picker, lazygit, other goodies
    { src = "https://github.com/neovim/nvim-lspconfig" },                               -- for simple LSP setup
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },                     -- better code navigation
    { src = "https://github.com/folke/which-key.nvim" },                                -- crutch
    { src = "https://github.com/catppuccin/nvim",                name = "catppuccin" }, -- style
    { src = "https://github.com/lewis6991/gitsigns.nvim" },                             -- git management
})

require("config.options")
require("config.keymaps")
require("config.autocmds")
