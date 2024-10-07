return { -- Fuzzy Finder (files, lsp, etc)
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = "^1.0.0",
    },
    { -- If encountering errors, see telescope-fzf-native README for install instructions
      "nvim-telescope/telescope-fzf-native.nvim",

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = "make",

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    -- Useful for getting pretty icons, but requires a Nerd Font.
    {
      "nvim-tree/nvim-web-devicons",
      enabled = vim.g.have_nerd_font,
    },
    "joshmedeski/telescope-smart-goto.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    require("telescope").setup({
      defaults = {
        ripgrep_arguments = {
          "rg",
          "--hidden",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")
    local map = function(m, l, r, desc)
      vim.keymap.set(m, l, r, { noremap = true, silent = true, desc = "Telescope: " .. desc })
    end

    -- git mappings
    map("n", "<leader>gc", builtin.git_commits, "[S]earch Git [C]ommits")
    map("n", "<leader>gb", builtin.git_bcommits, "[S]earch Git [C]ommits for buffer")

    -- additionals
    map("n", "<leader>sn", "<cmd>Telescope noice<cr>", "[S]earch [N]oice output")

    -- telescope mappings
    map("n", "<leader>sf", builtin.find_files, "[S]earch [F]iles")
    map("n", "<leader>sb", builtin.buffers, "[S]earch [B]uffers")
    map("n", "<leader>sh", builtin.help_tags, "[S]earch [H]elp")
    map("n", "<leader>ss", builtin.lsp_document_symbols, "[S]earch [S]ymbols")
    map("n", "<leader>s.", builtin.oldfiles, '[S]earch [O]ld Files ("." for repeat)')
    map("n", "<leader>sw", builtin.grep_string, "[S]earch current [W]ord")
    map("n", "<leader>sk", builtin.keymaps, "[S]earch [K]eymaps")
    map("n", "<leader>sd", builtin.diagnostics, "[S]earch [D]iagnostics")
    map("n", "<leader>ss", builtin.builtin, "[S]earch [S]elect Telescope")
    map("n", "<leader>sg", builtin.live_grep, "[S]earch by [G]rep")
    map("n", "<leader>sr", builtin.resume, "[S]earch [R]esume")
    -- vim.keymap.set("n", "<leader>/", builtin.buffers, { desc = "[/] Find existing buffers" })

    -- Slightly advanced example of overriding default behavior and theme
    map("n", "<leader><leader>", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, "[ ] Fuzzily search in current buffer")

    -- Also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    map("n", "<leader>s/", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, "[S]earch [/] in Open Files")

    -- Shortcut for searching your neovim configuration files
    map("n", "<leader>sc", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, "[S]earch [N]eovim files")

    -- Enable telescope extensions, if they are installed
    vim.g.zoxide_use_select = true
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("noice")
    require("telescope").load_extension("live_grep_args")
    -- require("telescope").load_extension "colors"
    -- require("telescope").load_extension "neoclip"
    -- require("telescope").load_extension "undo"
    -- require("telescope").load_extension "advanced_git_search"
  end,
}
