return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- ===============
  -- === THEMES ===
  -- ===============:
  use {
    'gruvbox-community/gruvbox',
    config = function()
      -- We actively set gruvbox as our theme
      vim.cmd([[colorscheme gruvbox]])
    end
  }

  -- =======================
  -- === TOGGLE TERMINAL ===
  -- =======================
  use {
    "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
      require("toggleterm").setup({
        size = 15,                  -- Height of the terminal
        open_mapping = [[<C-\>]],   -- Keybinding to toggle terminal
        direction = "horizontal",   -- Open terminal below
        shading_factor = 2,         -- Dim the terminal slightly
        start_in_insert = true,     -- Start in insert mode
        persist_size = true,        -- Preserve size across toggles
      })

      -- Example keybinding to toggle terminal
      vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>', { noremap = true, silent = true })
    end,
  }

  -- ====================
  -- === FILE EXPLORER ==
  -- ====================
  use {
    'nvim-tree/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-tree').setup({
        view = {
          width = 30,
          side = "left",
          preserve_window_proportions = true,
        },
      })

      -- Keybindings to handle tree focus and toggle
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>n', ':NvimTreeFocus<CR>',  { noremap = true, silent = true })
    end,
  }
  -- ====================
  -- === LSP & CMP    ===
  -- ====================
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'

  -- ============================
  -- === TREESITTER SYNTAX    ===
  -- ============================
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "lua", "javascript", "python", "zig", "c", "cpp" },
        highlight = { enable = true },
        incremental_selection = { enable = true },
        indent = { enable = true },
      })
    end,
  }

  -- ====================
  -- === STATUSLINE   ===
  -- ====================
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'auto',
        },
      })
    end,
  }

  -- =====================
  -- === TELESCOPE    ===
  -- =====================
  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').setup({})
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap=true, silent=true })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep,  { noremap=true, silent=true })
      vim.keymap.set('n', '<leader>fb', builtin.buffers,    { noremap=true, silent=true })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags,  { noremap=true, silent=true })
    end,
  }

  -- ====================
  -- === UTILITIES    ===
  -- ====================
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
    end,
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({})
    end,
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({})
    end,
  }
  use {
    'goolord/alpha-nvim',
    config = function()
      require('alpha').setup(require('alpha.themes.dashboard').config)
    end,
  }
end)

