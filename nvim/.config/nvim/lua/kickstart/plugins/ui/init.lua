---@module 'lazy'
---@type LazySpec
local submodulePath = 'kickstart.plugins.ui.'
return {
  require(submodulePath .. 'indent_line'),
  require(submodulePath .. 'mini'),
  require(submodulePath .. 'neo-tree'),
  require(submodulePath .. 'todo-comments'),
}
