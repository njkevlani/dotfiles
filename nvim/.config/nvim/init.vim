function SourceIfExists(file)
  let absPath = expand('~/.config/nvim/') . '/' . a:file
  if filereadable(l:absPath)
    exec 'source' l:absPath
  endif
endfunction

call plug#begin()
call SourceIfExists('plug-minimal.vim')
call SourceIfExists('plug-nvim-lsp.vim')
Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown' }
call plug#end()

call SourceIfExists('minimal.vim')
call SourceIfExists('scripts.vim')
call SourceIfExists('mappings.vim')
call SourceIfExists('nvim-lsp.vim')
