---@module 'lazy'
---@type LazySpec
local submodulePath = 'kickstart.plugins.utils.'
return {
  require(submodulePath .. 'conform'),
  require(submodulePath .. 'telescope'),
  require(submodulePath .. 'lint'),
  require(submodulePath .. 'which-key'),
}
