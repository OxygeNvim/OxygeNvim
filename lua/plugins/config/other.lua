local M = {}

local base46 = require('base46')

M.aerial = function()
  local aerial = require('aerial')

  base46.load_highlight('aerial')

  aerial.setup(utils.merge({
    layout = {
      min_width = 20,
    },
  }, config.plugins.config['aerial.nvim'] or {}))
end

M.templatestring = function()
  local templatestring = require('template-string')

  templatestring.setup(utils.merge({
    jsx_brackets = true,
    remove_template_string = false,
    restore_quotes = {
      normal = [[']],
      jsx = [["]],
    },
  }, config.plugins.config['template-string.nvim'] or {}))
end

M.devicons = function()
  local devicons = require('nvim-web-devicons')
  local icons = require('core.ui.icons')

  base46.load_highlight('devicons')

  devicons.setup({
    override = icons.devicons,
    color_icons = true,
    default = true,
  })
end

M.which_key = function()
  local which_key = require('which-key')

  base46.load_highlight('whichkey')

  which_key.setup(utils.merge({
    plugins = {
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = true,
        nav = true,
        z = true,
        g = false,
      },
    },
    operators = { gc = 'Comments' },
    window = {
      border = 'none',
      position = 'bottom',
      margin = { 0, 0, 1, 0 },
      padding = { 0, 1, 1, 0 },
      winblend = 10,
    },
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' },
  }, config.plugins.config['which-key.nvim'] or {}))
end

M.gitsigns = function()
  local gitsigns = require('gitsigns')

  base46.load_highlight('git')

  gitsigns.setup(utils.merge({
    preview_config = {
      border = config.ui.border,
      style = 'minimal',
    },
    signs = {
      add = { hl = 'DiffAdd', text = '│', numhl = 'GitSignsAddNr' },
      change = { hl = 'DiffChange', text = '│', numhl = 'GitSignsChangeNr' },
      delete = { hl = 'DiffDelete', text = '│', numhl = 'GitSignsDeleteNr' },
      topdelete = { hl = 'DiffDelete', text = '│', numhl = 'GitSignsDeleteNr' },
      changedelete = { hl = 'DiffChangeDelete', text = '~', numhl = 'GitSignsChangeNr' },
    },
  }, config.plugins['gitsigns.nvim'] or {}))
end

M.comment = function()
  local comment = require('Comment')

  comment.setup(utils.merge({
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  }, config.plugins.config['Comment.nvim'] or {}))
end

M.colorizer = function()
  local colorizer = require('colorizer')

  colorizer.setup(utils.merge({
    filetypes = {
      '*',
    },
    user_default_options = {
      RGB = true,
      RRGGBB = true,
      names = false,
      RRGGBBAA = false,
      rgb_fn = false,
      hsl_fn = false,
      css = false,
      css_fn = false,
      mode = 'background',
    },
  }, config.plugins.config['nvim-colorizer.lua'] or {}))

  vim.defer_fn(function()
    colorizer.attach_to_buffer(0)
  end, 0)
end

M.editorconfig = function()
  r('editorconfig')
end

M.autopairs = function()
  local nvim_autopairs = require('nvim-autopairs')
  local ok_cmp, cmp = r('cmp')
  if not ok_cmp then
    return false
  end

  nvim_autopairs.setup()
  cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done({ map_char = { tex = '' } }))
end

return M
