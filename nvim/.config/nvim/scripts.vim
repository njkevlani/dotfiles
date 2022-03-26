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

nnoremap <C-q> :call ToggleQFList()<CR>
