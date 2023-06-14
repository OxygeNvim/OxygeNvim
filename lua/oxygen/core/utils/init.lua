_G.utils = {
  logger = {},
  keymaps = {},
  filesystem = {},
}

for _, util in pairs({
  'filesystem',
  'logger',
  'other',
  'table'
}) do
  require('oxygen.core.utils.' .. util)
end

return utils
