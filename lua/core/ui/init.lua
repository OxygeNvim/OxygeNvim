_G.ui = {
  statusline = {},
  lsp = {},
}

for _, module in pairs({
  'icons',
  'statusline',
  'lsp.rename',
}) do
  require('core.ui.' .. module)
end

return ui
