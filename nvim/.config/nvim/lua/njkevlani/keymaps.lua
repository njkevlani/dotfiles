local map = vim.keymap.set

-- Use space as leader.
vim.g.mapleader = " "

map("n", "<leader>q", "<cmd>bd<cr>", { desc = "Delete buffer" })

map("n", "<leader>h", "<C-w>h", { desc = "Go to left window" })
map("n", "<leader>j", "<C-w>j", { desc = "Go to lower window" })
map("n", "<leader>k", "<C-w>k", { desc = "Go to upper window" })
map("n", "<leader>l", "<C-w>l", { desc = "Go to right window" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter normal mode while in terminal" })

map("n", "<leader>d", "\"_d", { desc = "Delete without yanking" })
map("v", "<leader>d", "\"_d", { desc = "Delete without yanking" })
map("v", "<leader>p", "\"_dP", { desc = "Paste without yanking" })

map("n", "<leader>e", "<cmd>Explore<cr>", { desc = "Open Netrw" })
