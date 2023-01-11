local defaults = require('core.lsp.defaults')
local lspconfig = require('lspconfig')

local ok_mason = r('mason')
local ok_mason_lspconfig, mason_lspconfig = r('mason-lspconfig')
if ok_mason and ok_mason_lspconfig then
  mason_lspconfig.setup({})
end

require('base46').load_highlight('lsp')
r('core.lsp.ui')

for server_name, user_opts in pairs(config.lsp.servers) do
  -- luacheck: no unused
  if ok_mason and ok_mason_lspconfig then
    local install = user_opts.install
    if user_opts.install == nil then
      install = true
    else
      install = user_opts.install
    end

    if install then
      local Package = require('mason-core.package')
      local registry = require('mason-registry')

      local resolve_package = function(lspconfig_server_name)
        local Optional = require('mason-core.optional')
        local server_mapping = require('mason-lspconfig.mappings.server')

        return Optional.of_nilable(server_mapping.lspconfig_to_package[lspconfig_server_name])
          :map(function(package_name)
            local ok, pkg = pcall(registry.get_package, package_name)
            if ok then
              return pkg
            end
          end)
      end

      local mason_name, version = Package.Parse(server_name)
      resolve_package(mason_name):if_present(function(pkg)
        if not pkg:is_installed() then
          pkg:install({
            version = user_opts.version or version,
          })
        end
      end)
    end
  end

  local opts = defaults

  local ok_server, server_opts = r('core.lsp.servers.' .. server_name)
  if ok_server then
    opts = utils.merge(opts, server_opts)
  end

  if user_opts.config then
    if type(user_opts.config) == 'table' then
      opts = utils.merge(opts, user_opts.config)
    else
      utils.logger.warn('Expected table but got ' .. type(user_opts.config) .. ' in LSP, ' .. server_name .. ' config!')
    end
  end

  lspconfig[server_name].setup(opts)
end
