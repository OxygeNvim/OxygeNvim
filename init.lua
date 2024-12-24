for _, module in pairs({
  'core.utils',
  'core.default_config',
  'core',
}) do
  require('oxygen.' .. module)
end
