filetype plugin indent on
syntax on

set background=dark
set hidden
set mouse=a
set number
set relativenumber
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu

set completeopt
set t_Co=256

if $TERM !=? 'xterm-256color'
    set termguicolors
endif

" Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

let mapleader=" "

lua require("plugins")
lua require("opts")
lua require("diagnostics")
lua require("completion")

let g:sonokai_style = 'andromeda'
let g:sonokai_better_performance = 1

colorscheme sonokai

autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
nnoremap <Leader>f <cmd>lua vim.lsp.buf.format()<CR>

" Configure LSP code navigation shortcuts
nnoremap <silent> <c-]>     <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <c-k>     <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> K         <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi        <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gc        <cmd>lua vim.lsp.buf.incoming_calls()<CR>
nnoremap <silent> gd        <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr        <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gn        <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gs        <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gw        <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

nnoremap <silent> ga        <cmd>lua vim.lsp.buf.code_action()<CR>

nnoremap <silent> [x        <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> ]x        <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> ]s        <cmd>lua vim.diagnostic.show()<CR>

nnoremap <silent> <Leader>q  <cmd>Trouble<CR>

