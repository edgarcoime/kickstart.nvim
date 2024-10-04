-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap
local opts = function(desc)
	return { noremap = true, silent = true, desc = desc }
end

-- cutting single characters don't put to register
keymap.set("n", "x", '"_x"')

-- Diagnostic keymaps
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts("Open diagnostic [Q]uickfix list"))


-- Set ctrl q and ctrl s as save
keymap.set("n", "<C-s>", "<cmd>w!<cr>", opts("Force Write"))
keymap.set("n", "<C-q>", "<cmd>qa!<cr>", opts("Force Quit"))

-- TODO: Not working ?
-- keymap.set("n", "<leader>q", "<cmd>q!<CR>", { desc = "Close current buffer" }) --  move current buffer to new tab

-- editor configs
-- Toggle line wrap with <leader>w
vim.api.nvim_set_keymap(
	"n",
	"<leader>el",
	"<cmd>set wrap!<CR>",
	opts("Toggle line wrap")
)

-- tabs
keymap.set("n", "<leader>te", "<cmd>tabedit<cr>", opts("Edit tab"))
keymap.set("n", "<tab>", "<cmd>tabnext<Return><cr>", opts("Progress forward tabs"))
keymap.set("n", "<s-tab>", "<cmd>tabprev<Return><cr>", opts("Progress backward tabs"))
keymap.set("n", "<leader>tq", "<cmd>tabclose<cr>", opts("Close tab"))

-- window management
keymap.set("n", "\\", "<C-w>s", opts("Split window horizontally"))
keymap.set("n", "|", "<C-w>v", opts("Split window vertically"))

-- Move window
keymap.set("n", "<leader>th", "<C-w>h", opts("Move tab left"))
keymap.set("n", "<leader>tl", "<C-w>l", opts("Move tab right"))
keymap.set("n", "<leader>tj", "<C-w>j", opts("Move tab down"))
keymap.set("n", "<leader>tk", "<C-w>k", opts("Move tab up"))

-- resize window
keymap.set("n", "<C-S-h>", "<C-w><", opts("Resize left"))
keymap.set("n", "<C-S-l>", "<C-w>>", opts("Resize right"))
keymap.set("n", "<C-S-j>", "<C-w>-", opts("Resize down"))
keymap.set("n", "<C-S-k>", "<C-w>+", opts("Resize up"))

-- diagnostics
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts("Go to next diagnostic"))
