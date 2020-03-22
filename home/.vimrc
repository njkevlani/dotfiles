
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
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'tomasr/molokai'
Plug 'RRethy/vim-illuminate'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-signify'
Plug 'dense-analysis/ale'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf.vim'
call plug#end()


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

autocmd BufWritePre * :call CleanExtraSpaces()

" Open where I left it.
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g'\"" | endif

" TODO Find some way to identify the problem due to which underline is drawn


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
colorscheme molokai
syntax enable
filetype plugin on
filetype indent on
set nocompatible
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
set background=dark
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
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
set clipboard=unnamedplus
set titlestring=%t%(\ %r%M%w%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)
set title
set ruler
set rulerformat=%9(%l/%L\ %c%)
set wildmenu
set wildmode=longest:full,full
" set cmdheight=1
set backspace=eol,start,indent
set hidden
set whichwrap+=<,>,[,]
set incsearch
set magic
" set conceallevel=0
set undofile
set undodir=~/.vim/undo
set list
set listchars=tab:\┆│\ ,
set showcmd
set completeopt=noinsert,menuone,popup
set noshowmode
set belloff=esc,showmatch,wildmode

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=1

let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1
let g:go_metalinter_enabled = ['golint', 'govet', 'typecheck', 'deadcode', 'errcheck', 'gosimple', 'govet', 'ineffassign', 'staticcheck', 'structcheck', 'typecheck', 'unused', 'varcheck']

" TODO Uncomment when it does not give error while hovering over make, map, etc. Don't remember exact keywords.
" let g:go_auto_type_info = 1
" au filetype go inoremap <buffer> . .<C-x><C-o>

let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

let g:Illuminate_delay = 1000
let g:go_doc_popup_window = 1

let g:delimitMate_expand_cr = 1
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
map <C-b> :NERDTreeToggle<CR>
nnoremap n nzzzv
nnoremap N Nzzzv
cmap w!! w !sudo tee > /dev/null %
nmap <Home> ^
vmap <Home> ^
imap <Home> <ESC>^i
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>f :noh<CR>
nnoremap <leader>q :bd<CR>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>
nmap Q <NOP>
