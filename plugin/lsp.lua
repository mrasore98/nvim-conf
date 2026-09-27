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
    'jdtls',
    'zls'
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)

    if lang and vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf)
    end
  end,
})
