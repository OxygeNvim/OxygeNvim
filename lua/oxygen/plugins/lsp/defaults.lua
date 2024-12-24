return {
  autostart = true,
  capabilities = table.merge(
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities(),
    {
      textDocument = {
        completion = {
          completionItem = {
            documentationFormat = { 'markdown', 'plaintext' },
            snippetSupport = true,
            preselectSupport = true,
            insertReplaceSupport = true,
            labelDetailsSupport = true,
            deprecatedSupport = true,
            commitCharactersSupport = true,
            tagSupport = { valueSet = { 1 } },
            resolveSupport = {
              properties = {
                'documentation',
                'detail',
                'additionalTextEdits',
              },
            },
          },
        },
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    }
  ),
  on_attach = function(client, bufnr)
    require('oxygen.extensions.lsp.signature').setup(client, bufnr)

    if config.lsp.inlay_hints then
      vim.lsp.inlay_hint.enable(true)
    end

    if config.lsp.format_on_save then
      if client.supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
          group = require('oxygen.core.utils').create_augroup('FormatOnSave'),
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end
    end
  end,
}
