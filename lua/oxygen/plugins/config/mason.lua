local mason = require('mason')
local mason_lspconfig_mapping = require('mason-lspconfig.mappings.server')
local mason_lspconfig = require('mason-lspconfig')

base46.load_highlight('mason')

local packages = {}

local installServer = function(server_name)
  local install = config.lsp.servers[server_name].install
  if install == nil then
    install = true
  end

  return install
end

for server_name, _ in pairs(config.lsp.servers) do
  if installServer(server_name) then
    if mason_lspconfig_mapping[server_name] then
      table.insert(packages, mason_lspconfig_mapping[server_name])
    end
  end
end

mason_lspconfig.setup()
mason.setup(utils.merge({
  ensure_installed = packages,
  ui = {
    border = config.ui.border,
    icons = {
      server_installed = '✓',
      server_pending = '➜',
      server_uninstalled = '✗',
    },
  },
}, config.plugins.config['mason'] or {}))
