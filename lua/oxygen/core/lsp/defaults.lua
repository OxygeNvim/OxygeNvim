local lspconfig_util = require('lspconfig.util')

local M = {}

M.autostart = true

M.on_attach = function(client, bufnr)
  if config.lsp.format_on_save then
    if config.lsp.formatters[client.name] == true and client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ timeout_ms = 1500 })
        end,
      })
    end
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
