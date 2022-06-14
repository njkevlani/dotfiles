local actions = require('telescope.actions')
require('telescope').setup({
    defaults = {
        prompt_prefix = "λ ",
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
        },
    }
})

require("telescope").load_extension "file_browser"
