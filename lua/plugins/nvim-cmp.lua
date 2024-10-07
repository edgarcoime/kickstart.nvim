-- TODO: Move to lsp folder/file
return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Language server integration may not be needed?
      "onsails/lspkind.nvim", -- vs-code like pictograms

      "hrsh7th/cmp-buffer", -- source for text in buffer
      "hrsh7th/cmp-path", -- source for file system paths

      -- Luasnip recommendations
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip", -- for autocompletion

      -- copilot integration
      "zbirenbaum/copilot-cmp",
    },
    config = function()
      vim.opt.completeopt = { "menu", "menuone", "noselect", "preview" }
      vim.opt.shortmess:append("c")

      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      lspkind.init({})

      cmp.setup({
        -- add lsp sources here
        sources = {
          { name = "copilot" }, -- copilot
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" }, -- text within current buffer
          { name = "path" }, -- file system paths
        },

        -- Keybindings
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item({ behaviour = cmp.SelectBehavior.Insert }), -- previous suggestion
          ["<C-n>"] = cmp.mapping.select_next_item({ behaviour = cmp.SelectBehavior.Insert }), -- next suggestion
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-e>"] = cmp.mapping.abort(), -- close completion window
          ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
          -- ["<C-y>"] = cmp.mapping.confirm({ select = false }),
          ["<C-y>"] = cmp.mapping(cmp.mapping.confirm({
            behaviour = cmp.ConfirmBehavior.Insert,
            select = true,
          }, { "i", "c" })),
        }),

        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",
            symbol_map = { Copilot = "" },
          }),
        },

        -- look of window
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },
}
