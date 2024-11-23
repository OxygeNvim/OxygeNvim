return {
  {
    'mfussenegger/nvim-dap',
    main = 'dap',
    dependencies = { { 'nvim-dap-virtual-text' }, { 'nvim-dap-ui' } },
    keys = {
      { '<leader>e', '', desc = '+Debug' },
      {
        '<leader>eB',
        function()
          require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end,
        desc = 'Breakpoint Condition',
      },
      {
        '<leader>eb',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle Breakpoint',
      },
      {
        '<leader>ec',
        function()
          require('dap').continue()
        end,
        desc = 'Continue',
      },
      {
        '<leader>eC',
        function()
          require('dap').run_to_cursor()
        end,
        desc = 'Run to Cursor',
      },
      {
        '<leader>eg',
        function()
          require('dap').goto_()
        end,
        desc = 'Go to Line (No Execute)',
      },
      {
        '<leader>ei',
        function()
          require('dap').step_into()
        end,
        desc = 'Step Into',
      },
      {
        '<leader>ej',
        function()
          require('dap').down()
        end,
        desc = 'Down',
      },
      {
        '<leader>ek',
        function()
          require('dap').up()
        end,
        desc = 'Up',
      },
      {
        '<leader>el',
        function()
          require('dap').run_last()
        end,
        desc = 'Run Last',
      },
      {
        '<leader>eo',
        function()
          require('dap').step_out()
        end,
        desc = 'Step Out',
      },
      {
        '<leader>eO',
        function()
          require('dap').step_over()
        end,
        desc = 'Step Over',
      },
      {
        '<leader>ep',
        function()
          require('dap').pause()
        end,
        desc = 'Pause',
      },
      {
        '<leader>er',
        function()
          require('dap').repl.toggle()
        end,
        desc = 'Toggle REPL',
      },
      {
        '<leader>es',
        function()
          require('dap').session()
        end,
        desc = 'Session',
      },
      {
        '<leader>et',
        function()
          require('dap').terminate()
        end,
        desc = 'Terminate',
      },
      {
        '<leader>ew',
        function()
          require('dap.ui.widgets').hover()
        end,
        desc = 'Widgets',
      },
    },
    config = function()
      require('oxygen.base46').load_highlight('dap_ui')

      require('dap.ext.vscode').load_launchjs()

      for name, sign in pairs(require('oxygen.ui.icons').dap) do
        sign = type(sign) == 'table' and sign or { sign }
        vim.fn.sign_define(
          'Dap' .. name,
          { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] }
        )
      end

      local vscode = require('dap.ext.vscode')
      local json = require('plenary.json')
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end

      require('overseer').enable_dap()
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    main = 'dapui',
    dependencies = { { 'nvim-neotest/nvim-nio' } },
    event = { 'CmdlineEnter' },
    keys = {
      {
        '<leader>eu',
        function()
          require('dapui').toggle()
        end,
        desc = 'Dap UI',
      },
      {
        '<leader>ee',
        function()
          require('dapui').eval()
        end,
        desc = 'Eval',
        mode = { 'n', 'v' },
      },
    },
    opts = {},
    config = function(_, opts)
      require('oxygen.base46').load_highlight('dap_ui')

      local dap = require('dap')
      local dapui = require('dapui')

      dapui.setup(opts)

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close({})
      end
    end,
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    main = 'nvim-dap-virtual-text',
    opts = {},
  },
}
