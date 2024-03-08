return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'catppuccin'
  end,
  opts = {
    flavour = 'mocha',
    integrations = {},
  },

  -- configure integrations here
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'catppuccin',
    },
  },
}
