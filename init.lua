for _, module in pairs({
  'core.utils',
  'core.default_config',
  'core.lazy',
  'core',
}) do
  pcall(require, 'oxygen.' .. module)
end
