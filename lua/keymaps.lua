-- keymaps.lua

-- Set the leader key to space
vim.g.mapleader = " "

-- Helper function to simplify keybinding definitions
local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- ===============================
-- === Existing Keybindings ===
-- ===============================

-- Clear search highlights
map('n', '<leader>h', ':nohlsearch<CR>', "Clear Search Highlight")

-- File Explorer Toggles
map('n', '<leader>e', ':NvimTreeToggle<CR>', "Toggle NvimTree")
map('n', '<leader>n', ':NvimTreeFocus<CR>', "Focus NvimTree")

-- Terminal Management
map('n', '<leader>tt', ':split | terminal<CR>', "Open Terminal in Split")
map('n', '<leader>tc', ':close<CR>', "Close Terminal")
map('t', '<Esc>', '<C-\\><C-n>', "Exit Terminal Mode")

-- ===============================
-- === New Keybindings ===
-- ===============================

-- Ctrl+Z and Ctrl+Y for Undo and Redo in Normal Mode
map('n', '<C-z>', 'u', "Undo")
map('n', '<C-y>', '<C-r>', "Redo")

-- Ctrl+Z and Ctrl+Y for Undo and Redo in Insert Mode
map('i', '<C-z>', '<Esc>u', "Undo")
map('i', '<C-y>', '<C-r>', "Redo")

-- Ctrl+Z and Ctrl+Y for Undo and Redo in Visual Mode
map('v', '<C-z>', 'u', "Undo")
map('v', '<C-y>', '<C-r>', "Redo")

-- Optional: Ctrl+Z and Ctrl+Y in Command-line Mode
-- Uncomment the lines below if you want to add these mappings in Command-line mode
-- map('c', '<C-z>', '<C-u>u', "Undo in Command-line")
-- map('c', '<C-y>', '<C-r><C-r>', "Redo in Command-line")
