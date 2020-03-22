source /home/nilesh/.vimrc
set guioptions=Pd

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
imap <A-z> <C-X>s
imap <A-/> <Esc>gccji
nmap <A-/> <Esc>gccj
vmap <A-/> gc
map <A-g> <Esc>:Gstatus<CR>
map <A-a> <Esc>:CtrlPBuffer<CR>
autocmd FileType go nmap <A-i> :GoInfo<CR>
autocmd FileType go nmap <A-b> :w<CR>:GoTestCompile<CR>
autocmd FileType go nmap <A-r> :w<CR>:GoRun<CR>
autocmd FileType go nmap <A-p> :GoDecls<CR>
" autocmd FileType go imap <C-Space> <C-x><C-o>

set mousemodel=popup
function! ToggleMenuBar()
    let l:menu_option = strridx(&guioptions, "m")
    let l:toolbar_option = strridx(&guioptions, "T")
    if l:menu_option > 0
        set guioptions-=m
    else
        set guioptions+=m
    endif
endfunction
menu PopUp.Toggle\ Menu :call ToggleMenuBar()<CR>

set guifont=Monospace\ 12
