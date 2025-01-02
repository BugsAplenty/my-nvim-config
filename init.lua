-- init.lua
vim.cmd([[packadd packer.nvim]])

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.api.nvim_exec([[
  autocmd VimEnter * NvimTreeOpen | split | ToggleTerm
]], false)


require('plugins')        -- Plugins
require('options')        -- General settings
require('keymaps')        -- Keybindings
require('lsp')            -- LSP settings

