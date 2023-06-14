local mason_lspconfig = require('mason-lspconfig')

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

mason_lspconfig.setup({
  ensure_installed = get_packages(),
})
