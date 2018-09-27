"TODO
"  - Add mapping for auto indent
"  - Add some nice to have mappings
"  - Add mapping for toggling spell check
"  - Learn moving cursor around

"" " " " " " " " " " " " " " " " " " " ""
"" " " " " " " " " " " " " " " " " " " ""
""   ____        _   _                 ""
""  / __ \      | | (_)                ""
"" | |  | |_ __ | |_ _  ___  _ __  ___ ""
"" | |  | | '_ \| __| |/ _ \| '_ \/ __|""
"" | |__| | |_) | |_| | (_) | | | \__ \""
""  \____/| .__/ \__|_|\___/|_| |_|___/""
""        | |                          ""
""        |_|                          ""
"" " " " " " " " " " " " " " " " " " " ""
"" " " " " " " " " " " " " " " " " " " ""
set cursorline
set number
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
set background=dark
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


set titlestring=%t%(\ %r%M%w%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)
set title
set ruler
set rulerformat=%9(%l/%L\ %c%)
" Check it what this does
set wildmenu
set cmdheight=1
set backspace=eol,start,indent


" Change cursor shape
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"


" Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l

" Makes search act like search in modern browsers
set incsearch

" For regular expressions turn magic on
set magic

" Don't know if i need this
"set laststatus=2
"set statusline=%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ Line:\ %l/%L\ \ Column:\ %ccall plug#begin('~/.vim/plugged')


"" " " " " " " " " " " " " " " " " " ""
"" " " " " " " " " " " " " " " " " " ""
""   _____           _       _       ""
""  / ____|         (_)     | |      ""
"" | (___   ___ _ __ _ _ __ | |_ ___ ""
""  \___ \ / __| '__| | '_ \| __/ __|""
""  ____) | (__| |  | | |_) | |_\__ \""
"" |_____/ \___|_|  |_| .__/ \__|___/""
""                    | |            ""
"" " " " " " " " " " " " " " " " " " ""
"" " " " " " " " " " " " " " " " " " ""

" Delete trailing white space on save
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
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"" " " " " " " " " " " " " " " " " " " " " " " ""
"" " " " " " " " " " " " " " " " " " " " " " " ""
""  __  __                   _                 ""
"" |  \/  |                 (_)                ""
"" | \  / | __ _ _ __  _ __  _ _ __   __ _ ___ ""
"" | |\/| |/ _` | '_ \| '_ \| | '_ \ / _` / __|""
"" | |  | | (_| | |_) | |_) | | | | | (_| \__ \""
"" |_|  |_|\__,_| .__/| .__/|_|_| |_|\__, |___/""
""              | |   | |             __/ |    ""
""              |_|   |_|            |___/     ""
"" " " " " " " " " " " " " " " " " " " " " " " ""
"" " " " " " " " " " " " " " " " " " " " " " " ""

map <C-f> :FZF<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-w> :tabn<CR>
imap <C-c> <Esc>V"+yi
vmap <C-c> "+yi
imap <C-v> <Esc>"+pi
nmap <F6> :setlocal spell! spelllang=en_us<CR>
imap <F6> <Esc><F6>i

" " " " " " " " " " " " " " " " " " " "
" " " " " " " " " " " " " " " " " " " "
""  _____  _             _           ""
"" |  __ \| |           (_)          ""
"" | |__) | |_   _  __ _ _ _ __  ___ ""
"" |  ___/| | | | |/ _` | | '_ \/ __|""
"" | |    | | |_| | (_| | | | | \__ \""
"" |_|    |_|\__,_|\__, |_|_| |_|___/""
""                  __/ |            ""
""                 |___/             ""
" " " " " " " " " " " " " " " " " " " "
" " " " " " " " " " " " " " " " " " " "

call plug#begin()
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree'
Plug 'maralla/completor.vim'
Plug 'RRethy/vim-illuminate'
call plug#end()

" NerdTree
map <C-b> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" IndentLine
let g:indentLine_char = '┆'

" Completer
let g:completor_python_binary = '/home/nilesh/code/opensource/venv_python3/bin/python'

set conceallevel=0
