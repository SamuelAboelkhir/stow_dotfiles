local M = {}

M.map = vim.keymap.set

M.icons = {
  diagnostics = {
    Error = ' ',
    Warn = ' ',
    Info = ' ',
    Hint = ' ',
  },
}

return M
