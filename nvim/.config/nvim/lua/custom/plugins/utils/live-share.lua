return {
  'azratul/live-share.nvim',
  dependencies = {
    'jbyuki/instant.nvim',
  },
  config = function()
    vim.g.instant_username = 'BlackDovah'
    require('live-share').setup {}

    -- Key mappings for live-share commands
    vim.api.nvim_set_keymap('n', '<leader>ls', '<cmd>LiveShareServer<CR>', { noremap = true, silent = true, desc = 'Start Live Share server' })
    vim.api.nvim_set_keymap('n', '<leader>lj', ':LiveShareJoin ', { noremap = true, desc = 'Join Live Share session' })
  end,
}
