return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      preset = 'helix',
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
      },

      -- Document existing key chains
      spec = {
        { '<leader>f', group = '[F]ind' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>g', group = '[G]it Hunk', mode = { 'n', 'v' } },
        { '<leader>gl', group = '[G]it Lab', mode = { 'n', 'v' } },
        { '<leader>d', group = '[D]iagnostics' },
        { '<leader>s', group = '[S]earch and replace', mode = { 'n', 'v' } },
        { 'gr', group = '[L]sp' },
        { 'grT', group = '[T]rack callers/callees' },
        { '<leader>l', group = '[L]ive session' },
        { '<leader>H', group = '[H]arpoon' },
        { '<leader>D', group = '[D]ebug' },
        { '<leader>c', group = 'Do[c]s' },
        { '<leader>o', group = '[O]pen code' },
        { '<leader>b', group = '[B]uffers' },
        { '<leader>q', group = 'Session Management' },
        { '<leader>u', group = '[U]i toggles' },
        { '<leader><tab>', group = 'Tabs' },
        { '[', group = 'prev' },
        { ']', group = 'next' },
        { 'g', group = 'goto' },
        { 'gs', group = 'surround' },
        { 'z', group = 'fold' },
        {
          '<leader>b',
          group = 'buffer',
          expand = function()
            return require('which-key.extras').expand.buf()
          end,
        },
        {
          '<leader>w',
          group = 'windows',
          proxy = '<c-w>',
          expand = function()
            return require('which-key.extras').expand.win()
          end,
        },
        -- better descriptions
        { 'gx', desc = 'Open with system app' },
      },
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Keymaps (which-key)',
      },
      {
        '<leader><c-h>',
        function()
          require('which-key').show { keys = '<leader>', loop = true }
        end,
        desc = 'Window Hydra Mode (which-key)',
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
