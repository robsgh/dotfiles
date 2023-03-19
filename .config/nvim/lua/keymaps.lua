vim.g.mapleader = " "

local n_opts = { noremap = true, silent = true }
local t_opts = { noremap = true }

local keymap = vim.api.nvim_set_keymap

keymap("n", "<Leader>f", ":lua vim.lsp.buf.format()<CR>", { silent = true })
keymap("n", "<Leader>ca", ":CodeActionMenu<CR>", n_opts)
keymap("n", "<C-]>", ":lua vim.lsp.buf.definition()<CR>", n_opts)
keymap("n", "<C-k>", ":lua vim.lsp.buf.signature_help()<CR>", n_opts)
keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", n_opts)
keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", n_opts)
keymap("n", "gc", ":lua vim.lsp.buf.incoming_calls()<CR>", n_opts)
keymap("n", "gd", ":lua vim.lsp.buf.type_definition()<CR>", n_opts)
keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", n_opts)
keymap("n", "gn", ":lua vim.lsp.buf.rename()<CR>", n_opts)
keymap("n", "gs", ":lua vim.lsp.buf.document_symbol()<CR>", n_opts)
keymap("n", "gw", ":lua vim.lsp.buf.workspace_symbol()<CR>", n_opts)
keymap("n", "ga", ":lua vim.lsp.buf.code_action()<CR>", n_opts)
keymap("n", "[x", ":lua vim.diagnostic.goto_prev()<CR>", n_opts)
keymap("n", "]x", ":lua vim.diagnostic.goto_next()<CR>", n_opts)
keymap("n", "]s", ":lua vim.diagnostic.show()<CR>", n_opts)
keymap("n", "<Leader>q", ":Trouble<CR>", n_opts)

keymap("n", "<S-t>", ":FloatermToggle --name=floater --height=0.94 --width=0.93 --autoclose=2<CR>", n_opts)
keymap("t", "<Esc>", "<C-\\><C-n>:q<CR>", t_opts)
