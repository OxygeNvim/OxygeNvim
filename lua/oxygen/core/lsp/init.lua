local lspconfig = require('lspconfig')
local defaults = require('oxygen.core.lsp.defaults')

base46.load_highlight('lsp')

require('oxygen.core.lsp.ui')

for server_name, user_opts in pairs(config.lsp.servers) do
  local opts = vim.deepcopy(defaults)

  local ok_server, server_opts = r('oxygen.core.lsp.servers.' .. server_name)
  if ok_server then
    opts = utils.merge(opts, server_opts)
  end

  if user_opts.config and type(user_opts.config) == 'table' then
    opts = utils.merge(opts, user_opts.config)
  end

  lspconfig[server_name].setup(opts)
end
