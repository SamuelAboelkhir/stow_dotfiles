return {
  'andweeb/presence.nvim',
  {
    'ray-x/lsp_signature.nvim',
    event = 'BufRead',
    config = function()
      require('lsp_signature').setup()
    end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    'goolord/alpha-nvim',
    config = function()
      local builtin = require 'telescope.builtin'
      local dashboard = require 'alpha.themes.dashboard'
      require('alpha').setup(require('alpha.themes.dashboard').config)
      vim.keymap.set('n', '<leader>h', function()
        vim.cmd 'Alpha'
      end, { desc = 'Go home' })
      dashboard.section.header.val = {
        '██████╗ ██╗      █████╗  ██████╗██╗  ██╗',
        '██╔══██╗██║     ██╔══██╗██╔════╝██║ ██╔╝',
        '██████╔╝██║     ███████║██║     █████╔╝ ',
        '██╔══██╗██║     ██╔══██║██║     ██╔═██╗ ',
        '██████╔╝███████╗██║  ██║╚██████╗██║  ██╗',
        '╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝',
        '███╗   ██╗██╗   ██╗██╗███╗   ███╗',
        '████╗  ██║██║   ██║██║████╗ ████║',
        '██╔██╗ ██║██║   ██║██║██╔████╔██║',
        '██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║',
        '██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║',
        '╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝',
      }
      dashboard.section.buttons.val = {
        dashboard.button('e', '  New file', '<cmd>ene <CR>'),
        dashboard.button('f', '󰈞  Find file', builtin.find_files),
        dashboard.button('h', '󰊄  Recently opened files', builtin.oldfiles),
        dashboard.button('r', '  Frecency/MRU', '<cmd>Telescope frecency<cr>'),
        dashboard.button('g', '󰈬  Find word', builtin.live_grep),
        dashboard.button('m', '  Jump to bookmarks'),
        dashboard.button('l', '  Open last session', [[<cmd> lua require("persistence").load() <cr>]]),
        dashboard.button('q', '󰅚  Quit NVIM', ':qa<CR>'),
      }
    end,
  },
}
