return {
  'maskudo/devdocs.nvim',
  lazy = false,
  dependencies = {
    'folke/snacks.nvim',
  },
  cmd = { 'DevDocs' },
  keys = {
    {
      '<leader>co',
      mode = 'n',
      '<cmd>DevDocs get<cr>',
      desc = 'Get Devdocs',
    },
    {
      '<leader>ci',
      mode = 'n',
      '<cmd>DevDocs install<cr>',
      desc = 'Install Devdocs',
    },
    {
      '<leader>cv',
      mode = 'n',
      function()
        local devdocs = require 'devdocs'
        local installedDocs = devdocs.GetInstalledDocs()
        vim.ui.select(installedDocs, {}, function(selected)
          if not selected then
            return
          end
          local docDir = devdocs.GetDocDir(selected)
          -- prettify the filename as you wish
          Snacks.picker.files { cwd = docDir }
        end)
      end,
      desc = 'Get Devdocs',
    },
    {
      '<leader>cd',
      mode = 'n',
      '<cmd>DevDocs delete<cr>',
      desc = 'Delete Devdoc',
    },
  },
  opts = {
    ensure_installed = {
      --Java
      'kotlin~1.9',
      'spring_boot',

      --Go
      'go',

      --Webdev
      'axios',
      'html',
      'http',
      'css',
      'javascript',
      'typescript',
      'react',
      'nextjs',
      'node',
      'npm',

      --Database
      'postgresql~18',
      --Low level
      'c',
      'cpp',
      'rust',
      'zig',
      'gcc~14',
      'gcc~14_cpp',

      --Python
      'python~3.14',
      'numpy~2.2',
      'pandas~2',

      --Testing
      'playwright',

      --R
      'r',

      --Lua
      'lua~5.4',

      --Other
      'bash',
      'markdown',
      'docker',
    },
  },
}
