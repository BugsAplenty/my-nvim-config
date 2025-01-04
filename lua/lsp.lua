-- lsp.lua

-- ============================
-- === Import Required Modules ===
-- ============================

local cmp = require('cmp')
local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

-- ============================
-- === Diagnostic Signs Setup ===
-- ============================

-- Define custom diagnostic signs with icons
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

-- Register each diagnostic sign
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- ============================
-- === Autocompletion Setup ===
-- ============================

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- Integrate LuaSnip for snippets
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm completion with Enter
    ['<C-Space>'] = cmp.mapping.complete(),            -- Trigger completion with Ctrl+Space
    ['<Tab>'] = cmp.mapping.select_next_item(),        -- Navigate to next item with Tab
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),      -- Navigate to previous item with Shift+Tab
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- LSP source
    { name = 'luasnip' },  -- Snippets source
  }, {
    { name = 'buffer' },   -- Buffer source
    { name = 'path' },     -- Path source
  }),
})

-- ============================
-- === LSP Capabilities ===
-- ============================

-- Enhance LSP capabilities for autocompletion
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- ============================
-- === LSP on_attach Function ===
-- ============================

-- Define the on_attach function to set keybindings and other LSP features
local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- Define keybindings for LSP functions
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)          -- Go to definition
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)          -- Show references
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)      -- Go to implementation
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)      -- Rename symbol
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts) -- Code actions
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)                -- Hover documentation
  vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)                                                       -- Format buffer

  -- Enable document highlighting if supported
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- ============================
-- === Mason & Mason-LSPconfig ===
-- ============================

-- Setup Mason
mason.setup({
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- Setup Mason-LSPconfig
mason_lspconfig.setup({
  ensure_installed = { 'lua_ls', 'zls', 'pyright', 'clangd' }, -- List of LSP servers to install
  automatic_installation = true, -- Automatically install missing servers
})

-- Setup handlers for installed LSP servers
mason_lspconfig.setup_handlers({
  -- Default handler for all LSP servers
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
})

-- ============================
-- === Diagnostic Configuration ===
-- ============================

-- Configure diagnostic display
vim.diagnostic.config({
  virtual_text = {
    prefix = '●', -- Could be '●', '▎', '■', etc.
    spacing = 4,
    severity_sort = true,
  },
  signs = true,
  underline = true,
  update_in_insert = false, -- Don't show diagnostics while typing
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- ============================
-- === LSP Handlers ===
-- ============================

-- Enhance floating windows for hover and signature help with rounded borders
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = "rounded",
    focusable = false,
    style = "minimal",
    width = 60,
    height = 15,
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "rounded",
    focusable = false,
    style = "minimal",
    width = 60,
    height = 15,
  }
)
