-- File explorer like buffer
return {
  'stevearc/oil.nvim',
  event = 'VimEnter',
  -- Optional dependencies
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'mrjones2014/smart-splits.nvim',
  },
  config = function()
    local splits = require 'smart-splits'
    require('oil').setup {
      columns = {
        'icon',
        'permissions',
        'size',
        'mtime',
      },
      keymaps = {
        -- TODO: Change so that oil buffer can move to through buffers and tmux panes
        ['<C-h>'] = splits.move_cursor_left(),
        ['<C-l>'] = splits.move_cursor_right(),
        ['\\'] = 'actions.select_split',
        ['|'] = 'actions.select_vsplit',
      },
    }
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
