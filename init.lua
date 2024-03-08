-- need this line because not in default folder
vim.cmd 'set runtimepath^=~/.config/nvim-configs/kickstart'
require 'core'

-- TODO: Find a way to incorporate lazy in its own seperate module

-- require 'lazy'
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- any custom folder setup should be put in table here
require('lazy').setup({ { import = 'plugins' }, { import = 'plugins.lsp' } }, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detections = {
    notify = false,
  },
})
