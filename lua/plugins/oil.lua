-- File explorer like buffer
return {
  "stevearc/oil.nvim",
  event = "VimEnter",
  -- Optional dependencies
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "mrjones2014/smart-splits.nvim",
  },
  config = function()
    local splits = require("smart-splits")
    local oil = require("oil")
    oil.setup({
      use_default_keymaps = false,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-h>"] = splits.move_cursor_left(),
        ["<C-l>"] = splits.move_cursor_right(),
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
      },
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == ".." or name == ".git"
        end,
      },
      win_options = {
        wrap = true,
      },
    })

    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<leader>-", oil.toggle_float, { desc = "Open parent directory in floating window" })
  end,
}
