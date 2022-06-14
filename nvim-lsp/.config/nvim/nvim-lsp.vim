luafile ~/.config/nvim/lua/treesitter.lua
luafile ~/.config/nvim/lua/nvim-lsp.lua
luafile ~/.config/nvim/lua/nvim-cmp.lua
luafile ~/.config/nvim/lua/gopls-lsp.lua
luafile ~/.config/nvim/lua/signature.lua
luafile ~/.config/nvim/lua/nvim-lint-setup.lua

autocmd BufWritePre *.go lua OrgImports(1000)
autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePost <buffer> lua require('lint').try_lint()
autocmd CursorHold * lua vim.diagnostic.open_float()

set updatetime=2000
