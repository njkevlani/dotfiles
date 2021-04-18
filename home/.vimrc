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
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'tomasr/molokai'
Plug 'RRethy/vim-illuminate'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-signify'
Plug 'NLKNguyen/papercolor-theme'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'rust-lang/rust.vim'
Plug 'godlygeek/tabular'
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

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a

let s:wrapenabled = 0
function! ToggleWrap()
  set wrap nolist
  if s:wrapenabled
    set nolinebreak
    unmap j
    unmap k
    unmap 0
    unmap ^
    unmap $
    let s:wrapenabled = 0
  else
    set linebreak
    nnoremap j gj
    nnoremap k gk
    nnoremap 0 g0
    nnoremap ^ g^
    nnoremap $ g$
    vnoremap j gj
    vnoremap k gk
    vnoremap 0 g0
    vnoremap ^ g^
    vnoremap $ g$
    let s:wrapenabled = 1
  endif
endfunction


let g:qf_g_open = 0
fun! ToggleQFList()
    if g:qf_g_open == 1
        let g:qf_g_open = 0
        cclose
    else
        let g:qf_g_open = 1
        copen
    end
endfun

nnoremap <C-k> :cnext<CR>zz
nnoremap <C-j> :cprev<CR>zz
nnoremap <C-q> :call ToggleQFList()<CR>


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
colorscheme PaperColor
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
set clipboard=unnamedplus
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
set undodir=~/.vim/undo
set list
set listchars=tab:\┆│\ ,
set showcmd
set completeopt=noinsert,menuone,popup
set noshowmode
set belloff=esc,showmatch,wildmode
set laststatus=1
set splitbelow splitright


let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=1

let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_doc_popup_window = 1

let g:Illuminate_delay = 100

let g:delimitMate_expand_cr = 1

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'


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
let mapleader=" "
map <C-b> :NERDTreeToggle<CR>
nnoremap n nzzzv
nnoremap N Nzzzv
cmap w!! w !sudo tee > /dev/null %
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>f :noh<CR>
nnoremap <leader>q :bd<CR>
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
nmap Q <NOP>
nnoremap <leader>s :set spell<CR>

nnoremap <leader>tt :TagbarToggle<CR>

nnoremap <leader>c :let @+ = expand("%:p")<CR>
nnoremap <leader>C :%y<CR>
nnoremap <leader>d :execute '!oj d '.getreg('+').'&'<cr>
nnoremap <leader>t :!oj t -c "go run main.go"<cr>

nmap <leader>/ <Esc>gccj
vmap <leader>/ gc

map <leader>g <Esc>:Gstatus<CR>

map <leader>a <Esc>:Buffers<CR>

nnoremap <leader>d "_d

autocmd filetype go inoremap <buffer> <c-space> <C-x><C-o>
autocmd filetype go inoremap <buffer> <c-p> <esc>:GoInfo<cr>li
autocmd filetype go nnoremap <buffer> <leader>p :GoDiagnostics<cr>
