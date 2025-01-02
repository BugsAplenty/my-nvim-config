vim.g.mapleader = " "
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { noremap=true, silent=true })
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap=true, silent=true })
vim.keymap.set('n', '<leader>n', ':NvimTreeFocus<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tt', ':split | terminal<CR>', { noremap = true, silent = true }) -- Open terminal at the bottom
vim.keymap.set('n', '<leader>tc', ':close<CR>', { noremap = true, silent = true }) -- Close terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true }) -- Exit terminal mode

