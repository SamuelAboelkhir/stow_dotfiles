---@module 'lazy'
---@type LazySpec
local submodulePath = 'kickstart.plugins.coding.'
return {
  require(submodulePath .. 'autopairs'),
  require(submodulePath .. 'blink-cmp'),
  require(submodulePath .. 'gitsigns'),
  require(submodulePath .. 'lspconfig'),
  require(submodulePath .. 'treesitter'),
}
