local version = vim.version().minor
if version < 8 then
  error('You need Neovim v0.8+!')
  return
end

local default_providers = {
  'node',
  'perl',
  'python3',
  'ruby',
}
for _, provider in ipairs(default_providers) do
  vim.g['loaded_' .. provider .. '_provider'] = 0
end

local modules = {
  'impatient',
  'core.utils',
  'core.default_config',
  'core.bootstrap',
  'core',
}
for _, module in pairs(modules) do
  pcall(require, module)
end
