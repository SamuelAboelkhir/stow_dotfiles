return {
  'R-nvim/R.nvim',
  -- Only required if you also set defaults.lazy = true
  lazy = false,
  -- R.nvim is still young and we may make some breaking changes from time
  -- to time (but also bug fixes all the time). If configuration stability
  -- is a high priority for you, pin to the latest minor version, but unpin
  -- it and try the latest version before reporting an issue:
  -- version = "~0.1.0"
  config = function()
    local map = vim.keymap.set

    ---@type RConfigUserOpts
    local opts = {
      user_maps_only = true,
      hook = {
        on_filetype = function()
          vim.api.nvim_buf_set_keymap(0, 'n', '<Enter>', '<Plug>RDSendLine', {})
          vim.api.nvim_buf_set_keymap(0, 'v', '<Enter>', '<Plug>RSendSelection', {})
        end,
      },

      R_args = { '--quiet', '--no-save' },
      min_editor_width = 72,
      rconsole_width = 78,

      disable_cmds = {
        'RClearConsole',
        'RCustomStart',
        'RSPlot',
        'RSaveClose',
      },

      external_term = 'tmux split-window -hf',
    }
    if vim.env.R_AUTO_START == 'true' then
      opts.auto_start = 'on startup'
      opts.objbr_auto_start = true
    end
    require('r').setup(opts)

    local mappings = {
      -- Start
      { 'n', 'Ro', '<Plug>RStart' },
      { 'n', 'Rq', '<Plug>RClose' },
      { 'n', 'Rip', '<Plug>RPackages' },

      -- Send
      { 'n', 'Rl', '<Plug>RSendLine' },
      { 'n', 'Raa', '<Plug>RSendFile' },
      { 'n', 'Rpp', '<Plug>RSendParagraph' },
      { 'n', 'Rpd', '<Plug>RDSendParagraph' },
      { 'n', 'Rfc', '<Plug>RSendCurrentFun' },
      { 'n', 'Rfd', '<Plug>RDSendCurrentFun' },
      { 'n', 'Rfa', '<Plug>RSendAllFun' },
      { 'n', 'Rbb', '<Plug>RSendMBlock' },
      { 'n', 'Rbd', '<Plug>RDSendMBlock' },
      { 'n', 'Rsc', '<Plug>RSendChain' },
      { 'n', 'Rsu', '<Plug>RSendAboveLines' },
      { 'n', 'Rm', '<Plug>RSendMotion' },

      { 'v', 'Rs', '<Plug>RSendSelection' },
      { 'v', 'Rsd', '<Plug>RDSendSelection' },

      -- Commands
      { 'n', 'Rrg', '<Plug>RPlot' },
      { 'n', 'Rrs', '<Plug>RSummary' },
      { 'n', 'Rrh', '<Plug>RHelp' },
      { 'n', 'Rra', '<Plug>RShowArgs' },
      { 'n', 'Rrl', '<Plug>RListSpace' },
      { 'n', 'Rrm', '<Plug>RClearAll' },
      { 'n', 'Rrt', '<Plug>RObjectStr' },
      { 'n', 'Rrp', '<Plug>RObjectPr' },
      { 'n', 'Rrn', '<Plug>RObjectNames' },
      { 'n', 'Rrd', '<Plug>RSetwd' },

      -- Knit
      { 'n', 'Rka', '<Plug>RMakeAll' },
      { 'n', 'Rkh', '<Plug>RMakeHTML' },
      { 'n', 'Rkp', '<Plug>RMakePDFK' },
      { 'n', 'Rkw', '<Plug>RMakeWord' },
      { 'n', 'Rkr', '<Plug>RMakeRmd' },
      { 'n', 'Rko', '<Plug>RMakeODT' },
      { 'n', 'Rkl', '<Plug>RMakePDFKb' },

      -- Object browser
      { 'n', 'Rro', '<Plug>ROBToggle' },
      { 'n', 'Rr=', '<Plug>ROBOpenLists' },
      { 'n', 'Rr-', '<Plug>ROBCloseLists' },
    }

    for _, m in ipairs(mappings) do
      map(m[1], '<leader>' .. m[2], m[3], {
        remap = true,
        silent = true,
      })
    end

    require('which-key').add {
      { '<leader>R', group = 'R.nvim' },

      { '<leader>Rr', group = 'R Commands' },
      { '<leader>Rk', group = 'R Knit' },
      { '<leader>Rf', group = 'R Functions' },
    }
  end,
}
