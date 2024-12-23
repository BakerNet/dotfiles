-- Create Browse command for use by Fugitive :GBrowse
vim.cmd([[
:command! -nargs=1 Browse silent execute '!$BROWSER' shellescape(<q-args>,1)
]])

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("hans")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
