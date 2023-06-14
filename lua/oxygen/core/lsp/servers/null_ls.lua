local defaults = require('oxygen.core.lsp.defaults')
local null_ls = require('null-ls')

local has_eslint_config = function(u)
  return u.root_has_file('.eslintrc') or u.root_has_file('.eslintrc.json') or u.root_has_file('.eslintrc.js')
end

local has_exec = function(exec)
  return vim.fn.executable(exec)
end

local sources = {}

if has_exec('prettierd') then
  table.insert(sources, {
    null_ls.builtins.formatting.prettierd.with({
      env = {
        PRETTIERD_DEFAULT_CONFIG = vim.fn.getcwd() .. '/.prettierrc',
      },
    }),
  })
end

if has_exec('eslint_d') then
  table.insert(sources, {
    null_ls.builtins.code_actions.eslint_d.with({
      condition = has_eslint_config,
      prefer_local = 'node_modules/.bin',
    }),
    null_ls.builtins.diagnostics.eslint_d.with({
      condition = has_eslint_config,
      prefer_local = 'node_modules/.bin',
    }),
  })
end

if has_exec('clang_format') then
  table.insert(sources, {
    null_ls.builtins.formatting.clang_format,
  })
end

if has_exec('shfmt') then
  table.insert(sources, {
    null_ls.builtins.formatting.shfmt,
  })
end

if has_exec('stylua') then
  table.insert(sources, {
    null_ls.builtins.formatting.stylua,
  })
end

if has_exec('black') then
  table.insert(sources, {
    null_ls.builtins.formatting.black,
  })
end

null_ls.setup(utils.merge({
  sources = sources,
}, defaults, config.lsp.null_ls or {}))
