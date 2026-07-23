vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.keymap.set('n', ' ', ':nohlsearch<CR>')
vim.keymap.set('n', '<leader>w', ':wa!<CR>')
vim.keymap.set('n', '<leader>q', ':close<CR>')

vim.keymap.set('n', '[g', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next)

vim.keymap.set('n', '0', '^')

vim.keymap.set("n", "<C-_>", "gcc", { remap = true, desc = "Toggle Comment" })
vim.keymap.set("v", "<C-_>", "gc", { remap = true, desc = "Toggle Comment" })
