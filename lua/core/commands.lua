local commands = {}

local c = vim.cmd

commands.updateTsParsers = function()
  local ok_treesitter, _ = r('nvim-treesitter')
  if ok_treesitter then
    pcall(c, 'TSUpdate')
  end
end

commands.sync = function()
  if utils.in_headless then
    vim.api.nvim_create_autocmd('User LazySync', {
      pattern = '*',
      callback = function()
        utils.logger.log('Done!')
        vim.cmd('qa')
      end,
    })
  else
    utils.logger.warn('Please restart neovim after plugins updated/installed!')
  end

  utils.logger.log('Updating plugins...')
  require('lazy').sync()

  if not utils.in_headless then
    commands.updateTsParsers()
  end
end

vim.api.nvim_create_user_command('OxygenSync', commands.sync, {
  desc = 'Updates all plugins and treesitter parsers',
})

vim.api.nvim_create_user_command('Format', function()
  vim.lsp.buf.format({ async = true })
end, {
  desc = 'Formats the current file if lsp is available and has formatting support',
})

return commands
