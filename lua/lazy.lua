-- TODO: Configure lazy to run through this file instead of init.lua
-- Ensures Lazy plugin manager is installed
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

require('lazy').setup 'plugins'

-- any custom folder setup should be put in table here
-- require('lazy').setup {
--   install = {
--     colorscheme = {},
--   },
--   checker = {
--     enabled = true,
--     notify = false,
--   },
--   change_detections = {
--     notify = false,
--   },
-- }
