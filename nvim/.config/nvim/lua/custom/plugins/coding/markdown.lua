return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'OXY2DEV/markview.nvim' },
  lazy = false,
  priority = 49,
  -- ... All other options.
  preview = {
    icon_provider = 'internal', -- "mini" or "devicons"
  },
}
