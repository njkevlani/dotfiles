luafile ~/.config/nvim/lua/treesitter.lua
luafile ~/.config/nvim/lua/nvim-lsp.lua
luafile ~/.config/nvim/lua/nvim-cmp.lua
luafile ~/.config/nvim/lua/gopls-lsp.lua
luafile ~/.config/nvim/lua/signature.lua

autocmd BufWritePre *.go lua OrgImports(1000)
autocmd BufWritePre *.go lua vim.lsp.buf.formatting()

