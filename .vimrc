call plug#begin('~/.vim/plugged')
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree'
Plug 'maralla/completor.vim'
call plug#end()
" NerdTree
map <C-b> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" IndentLine
let g:indentLine_char = '┆'


" Completer
let g:completor_python_binary = '/home/nilesh/code/opensource/venv_python3/bin/python'
" Mappings
"TODO
"  - Add mapping for auto indent
"  - Add mapping for toggling spell check
"  - indentLine
"  - Learn moving cursor around

" Auto complete bracket
"imap {<cr> {<cr><cr>}<esc>ki
"imap ( () {<cr><esc>ki
map <C-f> :FZF<CR>
" Options
set number
set cursorline
filetype plugin on
filetype indent on
set autoread
set so=7
set ignorecase
set smartcase
set hlsearch
set lazyredraw
set showmatch
set mat=2
colorscheme default
syntax enable
set background=light

set encoding=utf8
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

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  silent! %s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfun

if has("autocmd")
  autocmd BufWritePre * :call CleanExtraSpaces()
endif

" Open where I left it.
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
endif

"silent e
"
set titlestring=%t%(\ %r%M%w%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)
set title
set ruler
"set rulerformat=%25(%F\(%L\)\ %l\ %c%)
set rulerformat=%9(%l/%L\ %c%)
"set rulerformat=%10(%l\ %c\|%p%%%)
" Check it what this does
set wildmenu
set cmdheight=1
set backspace=eol,start,indent

" Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l

" Makes search act like search in modern browsers
set incsearch

" For regular expressions turn magic on
set magic

" Don't know if i need this
"set laststatus=2
"set statusline=%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ Line:\ %l/%L\ \ Column:\ %c
