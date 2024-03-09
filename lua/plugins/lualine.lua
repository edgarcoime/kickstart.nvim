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

    local clients_lsp = function()
      local clients = vim.lsp.buf_get_clients()
      if next(clients) == nil then
        return ''
      end

      local c = {}
      for _, client in pairs(clients) do
        table.insert(c, client.name)
      end
      return 'LSP: ' .. table.concat(c, '|')
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
        },
        lualine_c = {
          clients_lsp,
          'diagnostics',
        },
      },
    }
  end,
}
