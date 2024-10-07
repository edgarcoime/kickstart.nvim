return {
  {
    "nvimdev/dashboard-nvim",
    enabled = false,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvimtools/none-ls.nvim", -- configure formatters & linters
      -- TODO: fix this in lualine
      -- {
      --   "ThePrimeagen/harpoon",
      --   branch = "harpoon2",
      --   requires = { { "nvim-lua/plenary.nvim" } },
      -- },
    },
    event = "VeryLazy",
    config = function()
      require("custom.lualine")
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          timeout = 3000,
          render = "wrapped-compact",
        },
      },
    },

    config = function()
      print("From noice")
      local keymap = vim.keymap
      keymap.set("n", "<leader>ed", "<cmd>NoiceDismiss<cr>", { desc = "Noice: Dismiss Noice messages", noremap = true, silent = true })

      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
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
      })
    end,
  },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      require("custom.incline").renderWithIconName()
    end,
  },
}
