local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true -- shows absolute line num on cursor line

-- tabs and indentation
opt.tabstop = 2       -- 2 spaces for tabs
opt.shiftwidth = 2    -- 2 spaces for indent width
opt.expandtab = true  -- true
opt.autoindent = true -- copy indent from cur line when starting new

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true -- if you include mixed case assumes case sens search

-- cursor line
opt.cursorline = true
opt.cursorcolumn = true

-- appearance
-- WARN: Might screw up colors in allacrity
-- opt.termguicolors = true
opt.background = 'dark' -- colorchemes that can be light or dark will default dark
opt.signcolumn = 'yes'  -- show sign column so that text doesn't shift

-- backspace
opt.backspace = 'indent,eol,start' -- allow backspace on indent, endofline, or insert mode start pos

-- clipboard
opt.clipboard:append 'unnamedplus' -- use system clipboard as default reg

-- split windows
opt.splitright = true -- split v to right
opt.splitbelow = true -- split h borrom

-- turn off swap file
opt.swapfile = false

-- Set ctrl q and ctrl s as save
vim.keymap.set('n', '<C-s>', '<cmd>w!<cr>', { desc = 'Force Write' })
vim.keymap.set('n', '<C-q>', '<cmd>qa!<cr>', { desc = 'Force Quit' })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
