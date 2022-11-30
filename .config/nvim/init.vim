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

let g:sonokai_style = 'andromeda'
let g:sonokai_better_performance = 1

colorscheme sonokai

