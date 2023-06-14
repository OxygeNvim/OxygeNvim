return {
  autostart = true,
  capabilities = utils.merge({
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
    },
  }, vim.lsp.protocol.make_client_capabilities(), require('cmp_nvim_lsp').default_capabilities()),
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ timeout_ms = 1500 })
      end,
    })
  end,
}
