require("null-ls").setup({
    sources = {
        require("null-ls").builtins.diagnostics.golangci_lint,
    },
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
