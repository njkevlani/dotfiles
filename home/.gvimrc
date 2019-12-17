source /home/nilesh/.vimrc
set guioptions=P

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
nmap <A-z> 1z=
nmap <A-j> <Esc>gd
map <A-k> <C-o>
nmap <A-f> <Esc>:set noh<CR>
imap <A-/> <Esc>gccji
nmap <A-/> <Esc>gccj
vmap <A-/> gc
map <C-Tab> <Esc>:tabnext<CR>
map <C-S-Tab> <Esc>:tabprev<CR>
map <A-q> <Esc>:bd<CR>
autocmd FileType go imap <A-i> <ESC>:GoInfo<CR>i
autocmd FileType go nmap <A-b> :w<CR>:GoTestCompile<CR>
autocmd FileType go nmap <A-r> :w<CR>:GoRun<CR>
autocmd FileType go imap <C-Space> <C-x><C-o>

