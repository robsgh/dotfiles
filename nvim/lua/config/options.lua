-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.background = "dark" -- or "light" for light mode
vim.opt.number = true
vim.cmd([[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * :set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave * :set norelativenumber
  augroup END
]])

vim.opt.clipboard = ""
vim.opt.joinspaces = false
