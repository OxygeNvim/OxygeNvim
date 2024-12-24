for _, module in pairs({
  'editor',
  'autocmds',
  'keymaps',
  'lazy',
  'commands',
}) do
  require('oxygen.core.' .. module)
end
