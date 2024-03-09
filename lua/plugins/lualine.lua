return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'ThePrimeagen/harpoon',
  },
  event = 'VeryLazy',
  config = function()
    -- Custom harpoon component in status bar
    local function harpoon_component()
      local hMark = require 'harpoon.mark'
      local total_marks = hMark.get_length()

      if total_marks == 0 then
        return ''
      end

      local current_mark = '—'

      local mark_idx = hMark.get_current_index()
      if mark_idx ~= nil then
        current_mark = tostring(mark_idx)
      end

      return string.format('󱡅 %s/%d', current_mark, total_marks)
    end

    require('lualine').setup {
      options = {
        -- theme = 'horizon',
        theme = 'catppuccin',
        globalstatus = true,
      },
      sections = {
        lualine_b = {
          'branch',
          harpoon_component,
          'diff',
          'diagnostics',
        },
      },
    }
  end,
}
