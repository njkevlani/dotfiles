require('lint').linters_by_ft = {
    go = {'golangcilint',},
}

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
