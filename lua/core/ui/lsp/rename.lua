ui.lsp.rename_popup = function()
  local curr_name = vim.fn.expand('<cword>' .. ' ')

  local event = require('nui.utils.autocmd').event
  local Input = require('nui.input')

  local params = vim.lsp.util.make_position_params()

  local on_submit = function(new_name)
    if not new_name or #new_name == 0 or curr_name == new_name then
      return
    end

    params.newName = new_name

    vim.lsp.buf_request(0, 'textDocument/rename', params)
  end

  local popup_options = {
    border = {
      style = config.ui.border,
      text = {
        top = ' Rename ',
        top_align = 'left',
      },
    },
    highlight = 'Normal:Normal',
    relative = {
      type = 'buf',
      position = {
        row = params.position.line,
        col = params.position.character,
      },
    },
    position = {
      row = 1,
      col = 0,
    },
    size = {
      width = 25,
      height = 1,
    },
  }

  local input = Input(popup_options, {
    default_value = curr_name,
    on_submit = on_submit,
    prompt = '',
  })

  input:mount()

  input:map('n', '<ESC>', input.input_props.on_close, { noremap = true, silent = true })

  input:on(event.BufLeave, input.input_props.on_close, { once = true })
end

return ui.lsp.rename_popup
