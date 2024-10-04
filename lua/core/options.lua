local opt = vim.opt

vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = "a"

-- line numbers
opt.relativenumber = true
opt.number = true -- shows absolute line num on cursor line

-- tabs and indentation
opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- true
opt.autoindent = true -- copy indent from cur line when starting new
opt.smartindent = true
opt.smarttab = true

-- line wrapping
opt.wrap = true
opt.breakindent = true
opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
opt.linebreak = true

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- search settings
opt.ignorecase = true
opt.smartcase = true -- if you include mixed case assumes case sens search

-- cursor line
opt.cursorline = true
opt.cursorcolumn = true
opt.scrolloff = 10

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = "▏ ", trail = "·", nbsp = "␣" }

-- Save undo history
opt.undofile = true

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- appearance
-- WARN: Might screw up colors in allacrity
opt.termguicolors = true
opt.background = "dark" -- colorchemes that can be light or dark will default dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = {"start", "eol", "indent"}-- allow backspace on indent, endofline, or insert mode start pos

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default reg

-- split windows
opt.splitright = true -- split v to right
opt.splitbelow = true -- split h borrom
opt.splitkeep = "cursor"


-- turn off swap file
opt.swapfile = false
-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = "a"

-- Don't show the mode, since it's already in status line
opt.showmode = false

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Set ctrl q and ctrl s as save
vim.keymap.set("n", "<C-s>", "<cmd>w!<cr>", { desc = "Force Write" })
vim.keymap.set("n", "<C-q>", "<cmd>qa!<cr>", { desc = "Force Quit" })

-- TODO: is this even needed?
-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- misc
opt.path:append({"**"})
opt.wildignore:append({"*/node_modules/*"})
