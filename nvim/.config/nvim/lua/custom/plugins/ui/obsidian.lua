return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- latest stable release
  ft = 'markdown',
  event = { 'BufReadPre */Documents/Obsidian_vaults/**/*.md' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'hrsh7th/nvim-cmp', optional = true },
  },
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = 'all',
        path = vim.fn.expand '~/Documents/Obsidian_vaults',
      },
    },
  },
}
