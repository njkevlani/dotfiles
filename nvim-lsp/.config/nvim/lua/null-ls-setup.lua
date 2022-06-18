require("null-ls").setup({
    sources = {
        require("null-ls").builtins.diagnostics.golangci_lint,
        require("null-ls").builtins.hover.dictionary,
    },
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, 'n',  'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap=true, silent=true})
    end
})

vim.diagnostic.config({
    virtual_text = false,
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})
