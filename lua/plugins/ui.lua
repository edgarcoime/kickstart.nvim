return {
  {
    'nvimdev/dashboard-nvim',
    enabled = false,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        requires = { { 'nvim-lua/plenary.nvim' } },
      },
      'nvimtools/none-ls.nvim', -- configure formatters & linters
    },
    event = 'VeryLazy',
    config = function()
      require 'custom.lualine'
    end,
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },

    config = function()
      local keymap = vim.keymap

      local focused = true
      vim.api.nvim_create_autocmd('FocusGained', {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd('FocusLost', {
        callback = function()
          focused = false
        end,
      })

      require('noice').setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      }
    end,
  },

  {
    'rcarriga/nvim-notify',
    opts = {
      timeout = 2000,
      render = 'wrapped-compact',
    },
  },

  -- -- buffer line
  -- {
  -- 	"akinsho/bufferline.nvim",
  -- 	event = "VeryLazy",
  -- 	keys = {
  -- 		{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
  -- 		{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
  -- 	},
  -- 	opts = {
  -- 		options = {
  -- 			mode = "tabs",
  -- 			show_buffer_close_icons = false,
  -- 			show_close_icon = false,
  -- 		},
  -- 	},
  -- },

  -- filename
  {
    'b0o/incline.nvim',
    dependencies = {},
    event = 'BufReadPre',
    priority = 1200,
    config = function()
      local helpers = require 'incline.helpers'
      require('incline').setup {
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          local ft_icon, ft_color = require('nvim-web-devicons').get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          local buffer = {
            ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
            ' ',
            { filename, gui = modified and 'bold,italic' or 'bold' },
            ' ',
            guibg = '#363944',
          }
          return buffer
        end,
      }
    end,
  },
}
