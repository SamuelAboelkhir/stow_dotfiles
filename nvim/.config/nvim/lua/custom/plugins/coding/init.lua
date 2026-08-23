---@module 'lazy'
---@type LazySpec
local submodulePath = 'custom.plugins.coding.'
return {
  require(submodulePath .. 'R-nvim'),
  require(submodulePath .. 'autotag'),
  require(submodulePath .. 'jdtls'),
  require(submodulePath .. 'markdown'),
  require(submodulePath .. 'lazygit'),
  require(submodulePath .. 'visual_multi'),
  -- require (submodulePath .. '.treesiter.lua'),
  -- require(submodulePath .. 'gitlab'),
}
