local M = {}

local theme_file = vim.fn.expand '~/.local/state/omarchy/current/theme.name'

local watcher = vim.loop.new_fs_event()

local current_theme = nil

local function normalize_theme(theme)
  return theme:gsub('-', '')
end

local function get_theme()
  local ok, lines = pcall(vim.fn.readfile, theme_file)

  if not ok or not lines or not lines[1] then
    return nil
  end

  return vim.trim(lines[1])
end

function M.reload_theme()
  local theme = get_theme()

  if not theme then
    vim.notify('Could not determine Omarchy theme', vim.log.levels.WARN)
    return
  end

  if theme == current_theme then
    return
  end

  current_theme = theme

  vim.notify('Loading theme: ' .. theme, vim.log.levels.INFO)

  local ok, err = pcall(function()
    vim.cmd.colorscheme(theme)
  end)

  if not ok then
    local normalized = normalize_theme(theme)

    ok, err = pcall(function()
      vim.cmd.colorscheme(normalized)
    end)

    if ok then
      current_theme = normalized
      return
    end
  end

  if not ok then
    vim.notify('Failed to load theme: ' .. theme .. '\n' .. err, vim.log.levels.ERROR)
  end
end

function M.setup()
  -- load current theme immediately
  M.reload_theme()

  -- watch for theme changes
  watcher:start(
    theme_file,
    {},
    vim.schedule_wrap(function()
      M.reload_theme()
    end)
  )
end

return M
