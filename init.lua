require("vim._core.ui2").enable({})
-- PLUGINS
vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.nvim" },  -- the workhorse
    { src = "https://github.com/neovim/nvim-lspconfig" },  -- for simple LSP setup
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },  -- better code navigation
    { src = "https://github.com/folke/which-key.nvim" },  -- crutch
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },  -- style
    { src = 'https://github.com/dmtrKovalenko/fff' },  -- picker
})

-- This is needed to get the rust dylib for new versions of fff
-- NOTE: On fresh installs, this may fail.
-- To fix, run `:lua require("fff.download").download_or_build_binary()`
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'fff' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then vim.cmd.packadd('fff') end
      require('fff.download').download_or_build_binary()
    end
  end,
})

vim.g.fff = {
  lazy_sync = true,
  debug = { enabled = false, show_scores = true },
}

-- EDITOR OPTIONS
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.clipboard = "unnamedplus"  -- integrate with system clipboard
vim.opt.pumheight = 10  -- limit popup menu height
vim.diagnostic.config({
    virtual_text = false
})

-- KEYMAP CONFIG
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>qq', ':quit<CR>', {desc = "Quit"})
vim.keymap.set('n', '<leader>rr', ':restart<CR>', {desc = "Restart"})
-- window navigation
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')
--buffer navigation
vim.keymap.set('n', '<S-h>', ':bp<CR>', {desc = "Next buffer"})
vim.keymap.set('n', '<S-l>', ':bn<CR>', {desc = "Previous buffer"})
vim.keymap.set('n', '<C-d>', '<C-d>zz') -- Move down, centered
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- Move up, centered
-- diagnostics
vim.keymap.set('n', '<leader>ds', vim.diagnostic.open_float, {desc = "Show diagnostic"})
vim.keymap.set('n', '<leader>dt', function()
    local config = vim.diagnostic.config()
    vim.diagnostic.config({virtual_text = not config.virtual_text})
end, { desc = "Toggle inline diagnostics"} )

-- APPEARANCE
vim.o.winborder = "rounded"
require("catppuccin").setup({
    transparent_background = true,
    float = { transparent = true, solid = false }
})
vim.cmd.colorscheme "catppuccin-nvim"
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()
require("mini.statusline").setup()
require("mini.tabline").setup({})
require("which-key").setup({ preset = "helix" }) -- Apply theme and window pos

-- LANGUAGE SUPPORT
require('nvim-treesitter').install({'lua', 'rust', 'python'})
vim.lsp.enable({'lua_ls', 'ty', 'ruff', 'rust_analyzer'})
require("mini.completion").setup()

-- PICKER
local picker = require("fff")
picker.setup({
    prompt = '',
    title = 'FFF',
    layout = {
        prompt_position = 'top'
    },
})
vim.keymap.set('n', '<leader> ', picker.find_files, { desc = "Find files" })
vim.keymap.set('n', '<leader>/', picker.live_grep, { desc = "Grep"})

-- FILES
require("mini.files").setup({ window = { preview = true } })
vim.keymap.set('n', '<leader>f', MiniFiles.open, { desc = "Mini Files" })

-- UNCATEGORIZED
require("mini.ai").setup()
require("mini.surround").setup()


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

