local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local previewers = require('telescope.previewers')

local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local function theme_switcher()
  local bufnr = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(bufnr)

  local previewer = previewers.new_buffer_previewer({
    define_preview = function(self, entry)
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

      local ft = require('plenary.filetype').detect(bufname) or 'diff'
      require('telescope.previewers.utils').highlighter(self.state.bufnr, ft)

      base46.change_theme(entry.value)
    end,
  })

  -- our picker function: colors
  local picker = pickers.new({
    prompt_title = '󱥚 Change Theme',
    previewer = previewer,
    finder = finders.new_table({
      results = require('base46.themes').themes,
    }),
    sorter = conf.generic_sorter(),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)

        base46.change_theme(action_state.get_selected_entry()[1])
      end)
      return true
    end,
  })

  picker:find()
end

return require('telescope').register_extension({
  exports = { theme_switcher = theme_switcher },
})
