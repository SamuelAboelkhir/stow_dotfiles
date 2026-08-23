return {
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    opts = {
      preset = 'amongus',
      options = {
        show_source = {
          enabled = true,
        },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = { diagnostics = { virtual_text = false } },
  },
}
