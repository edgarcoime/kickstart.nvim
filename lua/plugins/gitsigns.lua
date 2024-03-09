-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following lua:
--    require('gitsigns').setup({ ... })
--
-- See `:help gitsigns` to understand what the configuration keys do
return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
  },
}

-- TODO: packages to setup still
-- nvim surround - surrounding more movement
-- nvim ufo - folding
-- nvim navic - signals
-- nvim-lsp-config
-- mason
-- mason-nvim-dap? - needd a debugger
-- conform? auto formatting
-- nvim-cmp - for copletion
-- snippets
-- todo comments bufenter
-- nvim treesitter context ? - optional kinda annoying
-- auto sessions
-- goolord
