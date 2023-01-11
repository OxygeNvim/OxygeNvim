local ok, base46 = r('base46')
if ok then
  base46.load_highlight('statusline')
end

local fn = vim.fn

local user_separator_style = config.ui.statusline.separator_style
local separator_l = ui.icons.separator_styles[user_separator_style]['left']
local separator_r = ui.icons.separator_styles[user_separator_style]['right']

local modes = {
  ['n'] = { 'NORMAL', 'C_NormalMode' },
  ['niI'] = { 'NORMAL i', 'C_NormalMode' },
  ['niR'] = { 'NORMAL r', 'C_NormalMode' },
  ['niV'] = { 'NORMAL v', 'C_NormalMode' },
  ['no'] = { 'N-PENDING', 'C_NormalMode' },
  ['i'] = { 'INSERT', 'C_InsertMode' },
  ['ic'] = { 'INSERT competion', 'C_InsertMode' },
  ['ix'] = { 'INSERT completion', 'C_InsertMode' },
  ['t'] = { 'TERMINAL', 'C_TerminalMode' },
  ['nt'] = { 'NTERMINAL', 'C_TerminalMode' },
  ['!'] = { 'SHELL', 'C_TerminalMode' },
  ['v'] = { 'VISUAL', 'C_VisualMode' },
  ['V'] = { 'V-LINE', 'C_VisualMode' },
  ['Vs'] = { 'V-LINE CTRL O', 'C_VisualMode' },
  [''] = { 'V-BLOCK', 'C_VisualMode' },
  ['R'] = { 'REPLACE', 'C_ReplaceMode' },
  ['Rv'] = { 'V-REPLACE', 'C_ReplaceMode' },
  ['s'] = { 'SELECT', 'C_SelectMode' },
  ['S'] = { 'S-LINE', 'C_SelectMode' },
  [''] = { 'S-BLOCK', 'C_SelectMode' },
  ['c'] = { 'COMMAND', 'C_CommandMode' },
  ['cv'] = { 'COMMAND', 'C_CommandMode' },
  ['ce'] = { 'COMMAND', 'C_CommandMode' },
  ['r'] = { 'PROMPT', 'C_ConfirmMode' },
  ['rm'] = { 'MORE', 'C_ConfirmMode' },
  ['r?'] = { 'CONFIRM', 'C_ConfirmMode' },
}

ui.statusline.mode = function()
  local m = vim.api.nvim_get_mode().mode
  local current_mode = '%#' .. modes[m][2] .. '#'
  local mode_sep = '%#' .. modes[m][2] .. 'Separator' .. '#'

  return current_mode .. ' ' .. modes[m][1] .. ' ' .. mode_sep .. separator_r
end

ui.statusline.filename = function()
  local filename = fn.fnamemodify(fn.expand('%:t'), ':r')
  local extension = fn.expand('%:e')

  if filename == '' then
    filename = 'Empty'
  end

  if extension ~= '' then
    filename = filename .. '.' .. extension
  end

  local icon = ui.icons.file

  local ok_devicons, devicons = r('nvim-web-devicons')
  if ok_devicons then
    local ft_icon = devicons.get_icon(filename, extension)
    icon = (ft_icon ~= nil and ft_icon) or ''
  end

  return '%#C_FileIcon#' .. ' ' .. icon .. ' ' .. '%#C_FileInfo#' .. filename .. ' ' .. '%#C_Separator#' .. separator_r
end

ui.statusline.git = function()
  if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
    return ''
  end

  local git_status = vim.b.gitsigns_status_dict
  local branch_name = ' ' .. ui.icons.branch .. ' ' .. git_status.head .. ' '

  return '%#C_GitIcon#' .. branch_name
end

ui.statusline.lsp_diagnostics = function()
  if not #vim.diagnostic.get(0) then
    return ''
  end

  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

  local _errors = (errors and errors > 0) and ('%#C_LspError#' .. ui.icons.error .. ' ' .. errors .. ' ') or ''
  local _warnings = (warnings and warnings > 0) and ('%#C_LspWarning#' .. ui.icons.warning .. ' ' .. warnings .. ' ')
    or ''
  local _hints = (hints and hints > 0) and ('%#C_LspHint#' .. ui.icons.hint .. ' ' .. hints .. ' ') or ''
  local _info = (info and info > 0) and ('%#C_LspInfo#' .. ui.icons.info .. ' ' .. info .. ' ') or ''

  return ' ' .. _errors .. _warnings .. _hints .. _info
end

ui.statusline.cursor_position = function()
  local left_sep = '%#C_Separator#' .. separator_l .. '%#C_PositionIcon#' .. ' '

  return left_sep .. '%#C_PositionText#' .. ' %3l:%-2v '
end

ui.statusline.run = function()
  return table.concat({
    ui.statusline.mode(),
    ui.statusline.filename(),
    ui.statusline.lsp_diagnostics(),

    '%=',

    ui.statusline.git(),
    ui.statusline.cursor_position(),
  })
end

return ui.statusline
