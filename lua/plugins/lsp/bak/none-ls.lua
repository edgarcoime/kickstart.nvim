return {
  'nvimtools/none-ls.nvim',               -- configure formatters & linters
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' }, -- to enable uncomment this
  dependencies = {
    'jay-babu/mason-null-ls.nvim',
    'nvimtools/none-ls-extras.nvim',
  },
  config = function()
    local mason_null_ls = require 'mason-null-ls'
    local null_ls = require 'null-ls'
    local null_ls_utils = require 'null-ls.utils'

    null_ls.setup()

    -- ensures formatters are installed
    mason_null_ls.setup {
      automatic_installation = true,
      ensure_installed = {
        'stylua', -- lua formatter
        -- 'black',  -- python formatter
        -- 'pylint', -- python linter

        -- Web config
        'prettier', -- prettier formatter
        'eslint_d', -- js linter,
      },
    }

    -- for conciseness
    local formatting = null_ls.builtins.formatting   -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- to setup format on save
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

    -- configure null-ls
    null_ls.setup {
      -- debugging null ls issues
      debug = true,
      -- add package.json as identifier for root (for typescript monorepos)
      -- root_dir = null_ls_utils.root_pattern('.null-ls-root', 'Makefile', '.git', 'package.json'),
      -- setup formatters & linters
      sources = {
        -- Needed otherwise errors
        -- https://stackoverflow.com/questions/78108133/issue-with-none-ls-configuration-error-with-eslint-d
        require 'none-ls.diagnostics.cpplint',
        require 'none-ls.formatting.jq',
        require 'none-ls.code_actions.eslint',

        --  to disable file types use
        --  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
        -- formatting.prettier.with {
        --   extra_filetypes = { 'svelte' },
        -- },                 -- js/ts formatter
        -- formatting.stylua, -- lua formatter
        null_ls.builtins.formatting.stylua,

        -- web config
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.eslint_d.with {
          condition = function(utils)
            return utils.root_has_file { '.eslintrc.js', '.eslintrc.cjs' } -- only enable if root has .eslintrc.js or .eslintrc.cjs
          end,
        },

        -- formatting.isort,
        -- formatting.black,
        -- diagnostics.pylint,
      },
      -- configure format on save
      on_attach = function(current_client, bufnr)
        if current_client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format {
                filter = function(client)
                  --  only use null-ls for formatting instead of lsp server
                  return client.name == 'null-ls'
                end,
                bufnr = bufnr,
              }
            end,
          })
        end
      end,
    }

    vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
  end,
}
