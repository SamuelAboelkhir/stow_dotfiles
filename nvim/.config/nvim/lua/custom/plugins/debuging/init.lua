---@module 'lazy'
---@type LazySpec
local submodulePath = 'custom.plugins.debuging.'
return {
  require(submodulePath .. '.diagnostic'),
  require(submodulePath .. '.trouble'),
}
