let g:vscode_style = "light"
colorscheme vscode
set mouse=a
set background=light
set cursorline
set number
set relativenumber
set autoread
set scrolloff=7
set ignorecase
set smartcase
set hlsearch
set lazyredraw
set showmatch
set mat=2
set encoding=utf-8
set ffs=unix,dos,mac
set nobackup
set nowritebackup
set noswapfile
set expandtab
set smarttab
set shiftwidth=4
set linebreak
set autoindent
set smartindent
set clipboard+=unnamedplus
set title
set wildmode=longest:full,full
set backspace=eol,start,indent
set incsearch
set undofile
set undodir=~/.cache/nvim/undo
set completeopt=menu,menuone,noinsert
set noshowmode
set splitbelow splitright
set tabstop=4
set shortmess+=c
set colorcolumn=80

let mapleader=" "

let g:delimitMate_expand_cr = 1

if exists('g:neovide')
    call SourceIfExists("neovide.vim")
endif
