local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

base46.load_highlight('mason')

local get_packages = function()
  local packages = {}

  for server_name, user_config in pairs(config.lsp.servers) do
    local install = user_config.install
    if install ~= false or install == nil then
      install = true
    end

    if install then
      table.insert(packages, server_name)
    end
  end

  return packages
end

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

vim.print(get_packages())

mason_lspconfig.setup({
  ensure_installed = get_packages(),
})
