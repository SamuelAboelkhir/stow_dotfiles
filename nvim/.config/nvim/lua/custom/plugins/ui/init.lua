---@module 'lazy'
---@type LazySpec
local submodulePath = 'custom.plugins.ui.'
return {
  require(submodulePath .. 'bufferline'),
  require(submodulePath .. 'lualine'),
  require(submodulePath .. 'noice'),
  require(submodulePath .. 'colorizer'),
  require(submodulePath .. 'notify'),
  require(submodulePath .. 'greeter'),
  require(submodulePath .. 'obsidian'),
}
