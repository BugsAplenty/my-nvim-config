local cmp = require('cmp')

-- Autocompletion setup
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm the completion
    ['<C-Space>'] = cmp.mapping.complete(),            -- Trigger completion
    ['<Tab>'] = cmp.mapping.select_next_item(),        -- Navigate forward in completion list
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),      -- Navigate backward in completion list
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- LSP source
    { name = 'luasnip' },  -- Snippets source
  }, {
    { name = 'buffer' },   -- Text from current buffer
    { name = 'path' },     -- Filesystem paths
  }),
})

-- LSP capabilities for completion
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP on_attach function for keybindings and features
local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)          -- Go to definition
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)          -- Show references
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)      -- Go to implementation
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)      -- Rename symbol
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts) -- Code actions
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)                -- Hover documentation
  vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)                                                       -- Format buffer
end

-- Zig LSP setup with enhanced capabilities and keybindings
require('lspconfig').zls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

