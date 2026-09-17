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
vim.keymap.set({ 'n', 't', 'i' }, '<C-_>', toggle_terminal, { desc = 'Toggle terminal' })
vim.keymap.set({ 'n', 't', 'i' }, '<C-/>', toggle_terminal, { desc = 'Toggle terminal' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
