return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPost',
  config = function()
    require('colorizer').setup({
      '*', -- Enable for all filetypes
    }, {
      css = true, -- Enable all CSS features (this includes lowercase names)
      mode = 'background', -- Display mode
    })
  end,
}
