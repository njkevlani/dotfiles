set statusline=
set statusline+=%{FugitiveStatusline()}         " Git info
set statusline+=\ %F                            " Path to the file
set statusline+=\ %y                            " File type
set statusline+=\ [%{strlen(&fenc)?&fenc:&enc}] " File encoding
set statusline+=%=                              " Switch to the right side
set statusline+=\ %m%r%w\                       " Modified? Readonly?
set statusline +=[0x%04B]\                      " Character under cursor
set statusline+=\@\ col:%03c                    " Current column
