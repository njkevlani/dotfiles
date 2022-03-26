" colorscheme PaperColor
set mouse=a
set background=light
syntax enable
filetype plugin on
filetype indent on
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
set t_co=256
set encoding=utf-8
set ffs=unix,dos,mac
set nobackup
set nowb
set noswapfile
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set lbr
set tw=500
set autoindent
set smartindent
set clipboard+=unnamedplus
set titlestring=%t%(\ %r%M%w%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)
set title
set ruler
set rulerformat=%9(%l/%L\ %c%)
set wildmenu
set wildmode=longest:full,full
set backspace=eol,start,indent
set hidden
set incsearch
set magic
set undofile
set undodir=~/.cache/nvim/undo
set list
set listchars=tab:\┆│\ ,
set showcmd
set completeopt=noinsert,menuone
set noshowmode
set belloff=esc,showmatch,wildmode
set laststatus=1
set splitbelow splitright
set shortmess+=c

let mapleader=" "

let g:delimitMate_expand_cr = 1

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

if exists('g:neovide')
  set guifont=Jetbrains\ Mono\ NL:h14
endif
