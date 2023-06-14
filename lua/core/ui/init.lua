_G.ui = {
  statusline = {},
  lsp = {},
}

local modules = {
  'icons',
  'statusline',
  'lsp.rename',
}
for _, module in pairs(modules) do
  require('core.ui.' .. module)
end

return ui
