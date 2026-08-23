return {
  'https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git',
  event = { 'BufReadPre', 'BufNewFile' },
  ft = {
    'go',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'python',
    'lua',
    'rust',
  },

  cond = function()
    return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= ''
  end,

  opts = {
    statusline = {
      enabled = true,
    },

    code_suggestions = {
      auto_filetypes = {
        'go',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'python',
        'lua',
        'rust',
      },

      ghost_text = {
        enabled = true,
        toggle_enabled = '<M-Space>',
        accept_suggestion = '<M-]>',
        clear_suggestions = '<M-[>',
        stream = true,
      },
    },
  },
}
