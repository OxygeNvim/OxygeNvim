local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

base46.load_highlight('mason')

local getLspServers = function()
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
      table.insert(packages, server_name)
    end
  end

  return packages
end

mason_lspconfig.setup({
  ensure_installed = getLspServers(),
  automatic_installation = true,
})

mason.setup(utils.merge({
  ui = {
    border = config.ui.border,
    icons = {
      server_installed = '✓',
      server_pending = '➜',
      server_uninstalled = '✗',
    },
  },
}, config.plugins.config['mason'] or {}))
