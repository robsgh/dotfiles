vim.cmd([[syntax enable]])

vim.opt.mouse = "a"
vim.opt.hidden = true
vim.opt.background = "dark"
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitright = true
vim.opt.splitbelow = true

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortmess: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {"menuone", "noselect", "noinsert"}
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option("updatetime", 300) 

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error 
-- Show inlay_hints more frequently 
vim.cmd([[
    set signcolumn=yes
    autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

local indent = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = indent 
vim.opt.tabstop = indent 
vim.opt.softtabstop = indent

vim.cmd([[
    colorscheme monokai-pro
]])

-- Used for which-key
vim.opt.timeout = true
vim.opt.timeoutlen = 500

