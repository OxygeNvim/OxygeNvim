local mason_lspconfig = require('mason-lspconfig')

local get_packages = function()
  local packages = {}

  for server_name, user_config in pairs(config.lsp.servers) do
    local install
    if user_config.install ~= false or user_config.install == nil then
      install = true
    else
      install = false
    end

    if install then
      table.insert(packages, server_name)
    end
  end

  return packages
end

mason_lspconfig.setup({
  ensure_installed = get_packages(),
})
