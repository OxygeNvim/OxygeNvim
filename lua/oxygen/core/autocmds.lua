local autocmd = vim.api.nvim_create_autocmd

autocmd('LspAttach', {
    callback = function(args)
      -- Disable semantic tokens
      -- TODO: fix this
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      client.server_capabilities.semanticTokensProvider = nil
    end,
})

autocmd('CursorHold *', {
    callback = function()
      vim.diagnostic.open_float(0, { scope = 'line', focusable = false, border = config.ui.border })
    end,
})
