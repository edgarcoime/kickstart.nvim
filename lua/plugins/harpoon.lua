-- Harpoon configs
return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'BufEnter',
  config = function()
    require('harpoon').setup {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    }

    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { desc = 'Harpoon: ' .. desc })
    end

    local hUI = require 'harpoon.ui'
    map('<C-m>', function()
      hUI.nav_file(1)
    end, 'Go to Bookmark 1')
    map('<C-,>', function()
      hUI.nav_file(2)
    end, 'Go to Bookmark 2')
    map('<C-.>', function()
      hUI.nav_file(3)
    end, 'Go to Bookmark 3')
    map('<C-/>', function()
      hUI.nav_file(4)
    end, 'Go to Bookmark 4')
    map('<C-e>', require('harpoon.ui').toggle_quick_menu, 'Toggle Menu')
    map('<leader>a', require('harpoon.mark').add_file, 'Append to fav')
  end,
}
