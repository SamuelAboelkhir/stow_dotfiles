---@module 'lazy'
---@type LazySpec
local submodulePath = 'custom.plugins.utils.'
return {
  require(submodulePath .. 'dadbod'),
  require(submodulePath .. 'devdocs'),
  require(submodulePath .. 'harpoon'),
  require(submodulePath .. 'live-share'),
  require(submodulePath .. 'markmap'),
  require(submodulePath .. 'session-manager'),
  require(submodulePath .. 'persistence'),
  require(submodulePath .. 'spectre'),
  require(submodulePath .. 'vim-tmux-nav'),
  require(submodulePath .. 'snacks'),
  require(submodulePath .. 'grug-far'),
  -- require(submodulePath .. 'present'),
  require(submodulePath .. 'opencode'),
  require(submodulePath .. 'claude-code'),
  require(submodulePath .. 'droast'),
}
