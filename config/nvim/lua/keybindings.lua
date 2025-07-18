vim.g.mapleader = " "

vim.keymap.set({'i', 'v'}, 'jk', '<ESC>', {})
vim.keymap.set({'i', 'v'}, 'kj', '<ESC>', {})
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', {})

--Disconnecting arrows
vim.api.nvim_set_keymap('n', '<Up>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Down>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Left>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Right>', '<Nop>', {noremap = true})

--Buffer toggle
vim.api.nvim_set_keymap('n', ',h', '<cmd>bp<CR>',{})
vim.api.nvim_set_keymap('n', ',l', '<cmd>bn<CR>',{})
vim.api.nvim_set_keymap('n', ',c', '<cmd>bd<CR>',{})

