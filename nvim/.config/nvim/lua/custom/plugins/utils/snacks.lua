return {
  {
    'folke/snacks.nvim',
    opts = {
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = false }, -- we set this in options.lua
      toggle = { map = vim.keymap.set },
      words = { enabled = true },
    },
  -- stylua: ignore
   keys = {
      {
        "<leader>n",
        function()
          local Snacks = require("snacks")
          if Snacks.config.picker ~= nil then
            Snacks.picker.notifications()
          else
            Snacks.notifier.show_history()
          end
        end,
        desc = "Notification History",
      },
      {
        "<leader>U",
        function()
          require("snacks").notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
      {
        "<leader>.",
        function()
          require("snacks").scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>S",
        function()
          require("snacks").scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },
      {
        "<leader>dps",
        function()
          require("snacks").profiler.scratch()
        end,
        desc = "Profiler Scratch Buffer",
      },
    },

    -- ⚙️ ALL plugin-dependent logic goes here
    config = function(_, opts)
      local Snacks = require 'snacks'

      -- apply opts (important!)
      Snacks.setup(opts)

      -- ===== Toggles =====
      Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
      Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
      Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'

      Snacks.toggle.diagnostics():map '<leader>ud'
      Snacks.toggle.line_number():map '<leader>ul'

      Snacks.toggle
        .option('conceallevel', {
          off = 0,
          on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
          name = 'Conceal Level',
        })
        :map '<leader>uc'

      Snacks.toggle
        .option('showtabline', {
          off = 0,
          on = vim.o.showtabline > 0 and vim.o.showtabline or 2,
          name = 'Tabline',
        })
        :map '<leader>uA'

      Snacks.toggle.treesitter():map '<leader>uT'
      Snacks.toggle
        .option('background', {
          off = 'light',
          on = 'dark',
          name = 'Dark Background',
        })
        :map '<leader>ub'

      Snacks.toggle.dim():map '<leader>uD'
      Snacks.toggle.animate():map '<leader>ua'
      Snacks.toggle.indent():map '<leader>ug'
      Snacks.toggle.scroll():map '<leader>uS'

      -- ===== Buffer actions =====
      vim.keymap.set('n', '<leader>bd', function()
        Snacks.bufdelete()
      end, { desc = 'Delete Buffer' })

      vim.keymap.set('n', '<leader>bo', function()
        Snacks.bufdelete.other()
      end, { desc = 'Delete Other Buffers' })

      vim.keymap.set('n', '<leader>bD', '<cmd>bd<cr>', { desc = 'Delete Buffer and Window' })
    end,
  },
}
