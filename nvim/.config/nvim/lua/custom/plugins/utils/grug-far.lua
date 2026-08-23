return {
  'MagicDuck/grug-far.nvim',
  -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
  -- additional lazy config to defer loading is not really needed...
  config = function()
    -- optional setup call to override plugin options
    -- alternatively you can set options with vim.g.grug_far = { ... }
    require('grug-far').setup {
      -- options, see Configuration section below
      -- there are no required options atm
    }
  end,
  vim.keymap.set({ 'n', 'x', 'v' }, '<leader>si', function()
    require('grug-far').open { visualSelectionUsage = 'operate-within-range' }
  end, { desc = 'grug-far: Search and replace locally' }),

  vim.keymap.set({ 'n', 'x', 'v' }, '<leader>sr', function()
    require('grug-far').open { prefills = { search = vim.fn.expand '<cword>' } }
  end, { desc = 'grug-far: Search and replace across the workspace' }),
}
