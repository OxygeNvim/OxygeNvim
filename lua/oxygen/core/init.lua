for _, module in pairs({
  'editor',
  'autocmds',
  'keymaps',
  'commands',
}) do
  require('oxygen.core.' .. module)
end
