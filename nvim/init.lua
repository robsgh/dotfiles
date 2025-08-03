vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = 'a'
vim.o.showmode = false

vim.o.termguicolors = true

vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true

vim.o.joinspaces = false

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split'

vim.o.cursorline = true

vim.o.scrolloff = 20

vim.keymap.set('n', '<leader>l', '<cmd>Lazy<CR>', { desc = 'Open LazyVim' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>f', '<cmd>Neotree reveal<CR>', { desc = 'Open NeoTree (reveal)' })
vim.keymap.set('n', '<leader>ur', '<cmd>nohlsearch<CR>', { desc = '[U]I [R]emove Search' })

require 'config.autocmds'
require 'config.lazy'
