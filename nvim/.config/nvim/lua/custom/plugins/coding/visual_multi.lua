return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
      -- Optional: change default keymaps or behaviors here
      vim.g.VM_default_mappings = 1
      -- vim.g.VM_maps = {
      --   ["Find Under"] = "<C-d>",
      --   ["Find Subword Under"] = "<C-d>",
      -- }
    end,
    lazy = false, -- load immediately
  },
}
