require('render-markdown').setup({
    completions = { lsp = { enabled = true }},
    headings = {
        icons = {},
    },
    code = {
        width = 'block',
        right_pad = 1,
    },
    sign = { enabled = false },
})
