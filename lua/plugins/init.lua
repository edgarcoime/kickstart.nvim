return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use

  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

  -- TODO: Double check to see if necessary
  -- { 'numToStr/Comment.nvim', opts = {} },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
}
