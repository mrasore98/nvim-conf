require("snacks").setup({
    picker = {
        enabled = true,
        sources = {
            help = {
                layout = {
                    preset = "ivy",
                    layout = {
                        position = "bottom"
                    }
                }
            }
        }
    },
    lazygit = { enabled = true },
})

-- Use snacks picker for all selections (e.g. code actions)
vim.ui.select = Snacks.picker.select

-- Picker keymaps
vim.keymap.set("n", "<leader> ", Snacks.picker.smart, { desc = "Find files" })
vim.keymap.set("n", "<leader>/", Snacks.picker.grep, { desc = "Grep" })
vim.keymap.set("n", "<leader>ff", Snacks.picker.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fb", Snacks.picker.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", Snacks.picker.help, { desc = "Search help" })


-- Git keymaps
vim.keymap.set("n", "<leader>gg", Snacks.lazygit.open, { desc = "LazyGit" })
