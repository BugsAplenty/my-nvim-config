-- plugins.lua

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- ===============
  -- === THEMES ===
  -- ===============
  use {
    'gruvbox-community/gruvbox',
    config = function()
      -- Set gruvbox as the colorscheme
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

      -- Keybinding to toggle terminal
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
        diagnostics = {
          enable = true,
          show_on_dirs = false,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },
      })

      -- Keybindings to handle tree toggle and focus
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>n', ':NvimTreeFocus<CR>',  { noremap = true, silent = true })
    end,
  }

  -- ====================
  -- === LSP & CMP    ===
  -- ====================
  use 'neovim/nvim-lspconfig'               -- LSP configurations
  use 'williamboman/mason.nvim'             -- Mason for managing LSP servers
  use 'williamboman/mason-lspconfig.nvim'   -- Mason bridge to lspconfig
  use 'hrsh7th/nvim-cmp'                    -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'                -- LSP source for nvim-cmp
  use 'L3MON4D3/LuaSnip'                    -- Snippets plugin
  use 'hrsh7th/cmp-buffer'                  -- Buffer completions
  use 'hrsh7th/cmp-path'                    -- Path completions
  use 'saadparwaiz1/cmp_luasnip'            -- Snippets source for nvim-cmp
  -- Removed 'onsails/lspkind-nvim' to exclude LSP kind icons

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
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { 'nvim-tree' },
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
      require('telescope').setup({
        defaults = {
          prompt_prefix = "  ",
          selection_caret = "  ",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            width = 0.9,
            height = 0.9,
            preview_cutoff = 120,
            prompt_position = "top",
          },
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
        pickers = {
          -- Your picker configurations can go here
        },
      })
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap=true, silent=true })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep,  { noremap=true, silent=true })
      vim.keymap.set('n', '<leader>fb', builtin.buffers,    { noremap=true, silent=true })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags,  { noremap=true, silent=true })
      -- Add global live_grep keybinding
      vim.keymap.set('n', '<leader>S', builtin.live_grep, { noremap = true, silent = true, desc = "Live Grep from anywhere" })
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

  -- ====================
  -- === Mason.nvim    ===
  -- ====================
  use {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end
  }

  use {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'zls', 'pyright', 'clangd' }, -- List of LSP servers to install
        automatic_installation = true, -- Automatically install missing servers
      })
    end
  }

  -- ====================
  -- === DIAGNOSTICS LIST ===
  -- ====================
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        icons = true,
        signs = { error = "", warning = "", hint = "", information = "" },
        use_diagnostic_signs = true,
      })

      -- Keybindings for Trouble
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, desc = "Toggle Trouble" })
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, desc = "Workspace Diagnostics" })
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, desc = "Document Diagnostics" })
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, desc = "Quickfix List" })
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, desc = "Location List" })
    end
  }
end)
