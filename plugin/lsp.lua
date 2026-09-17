-- LANGUAGE SUPPORT
require('nvim-treesitter').install({ 'lua', 'rust', 'python', 'nix' })
require('nvim-treesitter').setup({ highlight = { enable = true, additional_vim_regex_highlighting = false } })
vim.lsp.enable({
    'lua_ls',
    'ty',
    'ruff',
    'rust_analyzer',
    'nixd',
    'nil_ls',
    'java_language_server',
    'zls'
})
