if #config.lsp.servers > 0 then
  local ok_mason = r('mason')
  local ok_mason_lspconfig, mason_lspconfig = r('mason-lspconfig')

  if not ok_mason or not ok_mason_lspconfig then
    return false
  end

  mason_lspconfig.setup({})

  local Package = require('mason-core.package')
  local registry = require('mason-registry')
  local Optional = require('mason-core.optional')
  local server_mapping = require('mason-lspconfig.mappings.server')

  for server_name, user_opts in pairs(config.lsp.servers) do
    -- luacheck: no unused
    local install = user_opts.install
    if user_opts.install == nil then
      install = true
    else
      install = user_opts.install
    end

    if install then
      local resolve_package = function(lspconfig_server_name)
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
end
