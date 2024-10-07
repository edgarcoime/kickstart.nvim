return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local gs = require("gitsigns")

    local on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = "Gitsigns: " .. desc })
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, "Next Hunk")

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, "Previous Hunk")

      -- Actions
      map("n", "<leader>gs", gitsigns.stage_hunk, "Stage Hunk")
      map("n", "<leader>gr", gitsigns.reset_hunk, "Reset Hunk")
      map("v", "<leader>gs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Visual Stage Hunk")
      map("v", "<leader>gr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Visual Stage Hunk")
      map("n", "<leader>gS", gitsigns.stage_buffer, "Stage Buffer")
      map("n", "<leader>gu", gitsigns.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>gR", gitsigns.reset_buffer, "Reset Buffer")
      map("n", "<leader>gp", gitsigns.preview_hunk, "Preview Hunk")
      map("n", "<leader>gl", function()
        gitsigns.blame_line({ full = true })
      end, "Blame Line Full")
      map("n", "<leader>gd", gitsigns.diffthis, "Diff this")
      map("n", "<leader>gD", function()
        gitsigns.diffthis("~")
      end, "Diff this")
      map("n", "<leader>gtd", gitsigns.toggle_deleted, "Toggle deleted")
      map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, "Toggle line blame")

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select range of hunk")
    end

    gs.setup({
      -- signs = {
      -- 	add = { text = "│" },
      -- 	change = { text = "│" },
      -- 	delete = { text = "_" },
      -- 	topdelete = { text = "‾" },
      -- 	changedelete = { text = "~" },
      -- 	untracked = { text = "┆" },
      -- },
      current_line_blame = true,
      on_attach = on_attach,
    })
  end,
}
