local opt = vim.opt

-- Use system clipboard.
opt.clipboard = "unnamedplus"

-- Highlight the line where cursor is present.
opt.cursorline = true

-- Show numbers and relative numbers.
opt.number = true
opt.relativenumber = true

-- Put new window below or right of the current window. More natural sides for splitting.
opt.splitbelow = true
opt.splitright = true

-- Enable undo after file is closed.
opt.undofile = true

-- Always have 8 lines above/below while scrolling unless at the begining/end of the file.
opt.scrolloff = 8

-- Enable 24bit colors in TUI.
opt.termguicolors = true

-- Case insensitive searching UNLESS /C or capital in search.
opt.ignorecase = true
opt.smartcase = true

opt.background = "light"

-- Show tab as 4 char wide.
opt.tabstop = 4
