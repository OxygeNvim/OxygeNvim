local lspconfig_util = require('lspconfig.util')

local M = {}

M.autostart = true

M.on_attach = function(client, _)
  local auto_format_lock = false

  if config.lsp.formatters[client.name] == true then
    client.server_capabilities.document_range_formatting = true
    client.server_capabilities.document_formatting = true

    if config.lsp.format_on_save and not auto_format_lock then
      auto_format_lock = true

      vim.api.nvim_create_autocmd('BufWritePre <buf>', {
        callback = function()
          vim.lsp.buf.format({ timeout_ms = 1500 })
        end,
        nested = true,
      })
    end
  else
    client.server_capabilities.document_range_formatting = false
    client.server_capabilities.document_formatting = false
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
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
}

local ok_cmp_lsp, cmp_nvim_lsp = r('cmp_nvim_lsp')
if ok_cmp_lsp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

M.capabilities = capabilities

lspconfig_util.default_config.capabilities = M.capabilities

return M
