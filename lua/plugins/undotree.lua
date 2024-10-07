return {
  "mbbill/undotree",
  -- cmd = "UndotreeToggle",
  event = "VeryLazy",
  config = function()
    vim.keymap.set("n", "<leader>eu", "<cmd>UndotreeToggle<cr>", { desc = "[E]ditor toggle [U]ndotree", noremap = true, silent = true })

    -- Optional configuration for the plugin can go here
    vim.g.undotree_WindowLayout = 2 -- Example: Change window layout
    vim.g.undotree_SplitWidth = 35 -- Example: Set the width of the undotree window
    vim.g.undotree_SetFocusWhenToggle = 1 -- Focus the undotree when toggled
  end,
}
