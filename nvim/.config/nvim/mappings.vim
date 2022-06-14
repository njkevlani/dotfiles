nnoremap <C-k> :cnext<CR>zz
nnoremap <C-j> :cprev<CR>zz
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

map <leader>a <Esc>:Telescope buffers<CR>
map <leader>e <Esc>:Telescope find_files<CR>
map <leader>r <Esc>:Telescope live_grep<CR>

nnoremap <leader>d "_d

tnoremap <Esc> <C-\><C-n>

nmap <leader>t :Telescope<CR>
