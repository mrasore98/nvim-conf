require("vim._core.ui2").enable({})
-- PLUGINS

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

vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.nvim" },  -- the workhorse
    { src = "https://github.com/neovim/nvim-lspconfig" },  -- for simple LSP setup
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },  -- better code navigation
    { src = "https://github.com/folke/which-key.nvim" },  -- crutch
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },  -- style
    { src = 'https://github.com/dmtrKovalenko/fff' },  -- picker
    { src = "https://github.com/lewis6991/gitsigns.nvim" }, -- git management
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
vim.o.wrap = false
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
vim.keymap.set('n', '<leader>qq', ':qall<CR>', {desc = "Quit"})
vim.keymap.set('n', '<leader>rr', ':restart<CR>', {desc = "Restart"})
-- window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
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
-- LSP and formating
vim.keymap.set('n', 'lf', vim.lsp.buf.format, {desc = "Format buffer"}) 
vim.keymap.set({'n', 'i'}, '<C-s>', function()
    vim.lsp.buf.format()
    vim.cmd('write')
end, { desc = "Format and save" })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {desc = "Code actions"})
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, {desc = "Code rename"})
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
require('nvim-treesitter').install({'lua', 'rust', 'python', 'nix'})
vim.lsp.enable({'lua_ls', 'ty', 'ruff', 'rust_analyzer', 'nixd', 'nil_ls'})
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
require("gitsigns").setup()


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


-- TERMINAL
local terminal_buf

local function toggle_terminal()
    if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
        for _, win in ipairs(vim.fn.win_findbuf(terminal_buf)) do
            vim.api.nvim_win_close(win, true)
            return
        end
    end

    local new_terminal = not terminal_buf or not vim.api.nvim_buf_is_valid(terminal_buf)
    if new_terminal then terminal_buf = vim.api.nvim_create_buf(false, true) end

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    vim.api.nvim_open_win(terminal_buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        style = 'minimal',
        border = 'rounded',
    })
    if new_terminal then
        local shell = vim.o.shell:gsub('^"(.*)"$', '%1')
        vim.fn.termopen({ shell })
    end
    vim.cmd.startinsert()
end

-- Ctrl-/ is reported differently by different terminal emulators/OSes.
-- Git Bash/mintty reports it as <C-_>; macOS terminals may report it as <C-/>.
vim.keymap.set({ 'n', 't' }, '<C-_>', toggle_terminal, { desc = 'Toggle terminal' })
vim.keymap.set({ 'n', 't' }, '<C-/>', toggle_terminal, { desc = 'Toggle terminal' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
