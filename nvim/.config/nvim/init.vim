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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'tree-sitter/tree-sitter-go'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-signify'
Plug 'junegunn/fzf.vim'
Plug 'Raimondi/delimitMate'
Plug 'NLKNguyen/papercolor-theme'
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
nnoremap n nzzzv
nnoremap N Nzzzv
cmap w!! w !sudo tee > /dev/null %
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>f :noh<CR>
nnoremap <leader>q :bd<CR>
nmap Q <NOP>
nnoremap <leader>s :set spell<CR>

nmap <leader>/ <Esc>gccj
vmap <leader>/ gc

map <leader>g <Esc>:Git<CR>

map <leader>a <Esc>:Buffers<CR>
map <leader>e <Esc>:FZF<CR>

nnoremap <leader>d "_d

iab :time: <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

luafile ~/.config/nvim/lua/gopls-lsp.lua
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>


luafile ~/.config/nvim/lua/compe-config.lua

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })

luafile ~/.config/nvim/lua/treesitter.lua

autocmd BufWritePre *.go lua vim.lsp.buf.formatting()

if exists('g:neovide')
  set guifont=Jetbrains\ Mono\ NL:h14
endif

