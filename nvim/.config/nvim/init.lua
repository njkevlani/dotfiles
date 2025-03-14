vim.g.mapleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits
vim.opt.mouse = 'a'

-- Sync clipboard with OS
vim.opt.clipboard = 'unnamedplus'

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Highlight the line where cursor is at
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

-- Combines cmd line and status line.
vim.opt.cmdheight = 0

vim.keymap.set('n', '<Esc>', '<CMD>nohlsearch<CR>', { desc = '<ESC> will also clear highlights' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<leader>h', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>l', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>j', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>k', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- better indenting
vim.keymap.set('v', '<', '<gv', { desc = 'Stay in visual mode after indenting in visual mode' })
vim.keymap.set('v', '>', '>gv', { desc = 'Stay in visual mode after indenting in visual mode' })

vim.keymap.set('n', '<leader>q', '<CMD>bd<CR>', { desc = 'Buffer delete' })

vim.keymap.set('n', '<leader>/', 'gccj', { remap = true, desc = 'Comment current line and move down' })
vim.keymap.set('v', '<leader>/', 'gc', { remap = true, desc = 'Comment current selection' })

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('last_loc', { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Install `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require('lazy').setup({
  'tpope/vim-sleuth',   -- Detect tabstop and shiftwidth automatically

  'tpope/vim-surround', -- Delete/change/add parentheses/quotes/much more with ease

  {
    -- For git signs
    'echasnovski/mini.diff',
    opts = {
      view = {
        style = 'sign'
      }
    },
  },

  {
    -- For auto close parentheses
    'echasnovski/mini.pairs',
    config = true,
  },

  {
    -- LSP for java
    -- TODO: fix completion and linting for lombok generated code.
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    config = function()
      require('jdtls').start_or_attach({
        cmd = { 'jdtls' },
        root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
      })
    end
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'enter',
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
      },
      sources = {
        cmdline = {},
      },
      signature = {
        enabled = true,
        window = { border = 'rounded' },
      },
      completion = {
        list = {
          selection = {
            auto_insert = false,
          },
        },
        menu = {
          border = 'rounded',
          draw = {
            columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind', gap = 1 } },
          },
        },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
    config = function()
      local lspconfig = require('lspconfig')

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      lspconfig.gopls.setup { capabilities = capabilities }
      lspconfig.jsonnet_ls.setup { capabilities = capabilities }
      lspconfig.lua_ls.setup { capabilities = capabilities }
      lspconfig.pyright.setup { capabilities = capabilities }
      lspconfig.golangci_lint_ls.setup {}

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function()
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[LSP] Go to definition' })
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[LSP] Rename' })
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[LSP] Code Actions' })
        end,
      })
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local configs = require('nvim-treesitter.configs')

      configs.setup({
        ensure_installed = { 'go', 'bash', 'python', 'diff', 'dockerfile', 'jsonnet', 'just', 'markdown', 'scala', 'sql', 'yaml', 'lua', 'html', 'css' },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  {
    -- For formatting
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        go = {
          'goimports', -- removal of unused imports
          'gci',       -- better ordering of imports
          'gofumpt'    -- formating in general
        },
      },
      format_on_save = {
        timeout_ms = 5000,
        lsp_format = 'fallback',
      },
      formatters = {
        gci = {
          prepend_args = {
            -- Order for sorting imports
            '-s', 'standard',   -- std packages first
            '-s', 'default',    -- then pacakges that do not match any group
            '-s', 'localmodule' -- then local packages
          },
        },
      },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    enabled = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      pickers = {
        live_grep = {
          additional_args = { '--hidden' }
        },
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
        },
      },
    },
    keys = {
      { '<leader>f', '<cmd>Telescope<cr>',            desc = 'Telescope' },
      { '<leader>e', '<cmd>Telescope buffers<cr>',    desc = 'Telescope Buffers' },
      { '<leader>n', '<cmd>Telescope live_grep<cr>',  desc = 'Telescope Live Grep' },
      { '<leader>N', '<cmd>Telescope find_files<cr>', desc = 'Telescope Files' },
    },
  },

  {
    'nvim-tree/nvim-tree.lua',
    enabled = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      update_focused_file = {
        enable = true,
      },
    },
    keys = {
      { '<leader>1', '<cmd>NvimTreeToggle<cr>', desc = 'Toggole NvimTree' },
    },
  },

  {
    'zenbones-theme/zenbones.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    lazy = false,
    config = function()
      vim.opt.background = 'light'
      vim.cmd.colorscheme('seoulbones')
    end,
  },

  {
    'linrongbin16/gitlinker.nvim',
    keys = {
      { '<leader>gb', '<cmd>GitLink!<cr>', mode = { 'n', 'v' }, desc = 'Open git link' },
    },
    cmd = 'GitLink',
    config = true,
  },

  {
    'folke/snacks.nvim',
    lazy = false,
    -----@module 'snacks'
    ---@type snacks.Config
    opts = {
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      picker = {
        enabled = true,
        sources = {
          explorer = {
            hidden = true,
          },
          grep = {
            hidden = true,
          },
          files = {
            hidden = true,
          },
        },
      },
    },
    keys = {
      { '<leader><space>', function() Snacks.picker.smart() end,                 desc = 'Smart Find Files' },
      { '<leader>1',       function() Snacks.explorer() end,                     desc = 'File Explorer' },
      { '<leader>n',       function() Snacks.picker.grep() end,                  desc = 'Grep' },
      { '<leader>N',       function() Snacks.picker.files() end,                 desc = 'Grep' },
      { '<leader>sd',      function() Snacks.picker.diagnostics() end,           desc = 'Diagnostics' },
      { '<leader>sD',      function() Snacks.picker.diagnostics_buffer() end,    desc = 'Buffer Diagnostics' },
      { '<leader>sh',      function() Snacks.picker.help() end,                  desc = 'Help Pages' },
      { '<leader>sH',      function() Snacks.picker.highlights() end,            desc = 'Highlights' },
      { '<leader>si',      function() Snacks.picker.icons() end,                 desc = 'Icons' },
      { '<leader>sk',      function() Snacks.picker.keymaps() end,               desc = 'Keymaps' },
      { '<leader>sl',      function() Snacks.picker.loclist() end,               desc = 'Location List' },
      { '<leader>sm',      function() Snacks.picker.marks() end,                 desc = 'Marks' },
      { '<leader>sM',      function() Snacks.picker.man() end,                   desc = 'Man Pages' },
      { '<leader>sp',      function() Snacks.picker.lazy() end,                  desc = 'Search for Plugin Spec' },
      { '<leader>sq',      function() Snacks.picker.qflist() end,                desc = 'Quickfix List' },
      { '<leader>sR',      function() Snacks.picker.resume() end,                desc = 'Resume' },
      { '<leader>su',      function() Snacks.picker.undo() end,                  desc = 'Undo History' },
      { '<leader>uC',      function() Snacks.picker.colorschemes() end,          desc = 'Colorschemes' },
      { 'gd',              function() Snacks.picker.lsp_definitions() end,       desc = 'Goto Definition' },
      { 'gD',              function() Snacks.picker.lsp_declarations() end,      desc = 'Goto Declaration' },
      { 'gr',              function() Snacks.picker.lsp_references() end,        desc = 'References',            nowait = true },
      { 'gI',              function() Snacks.picker.lsp_implementations() end,   desc = 'Goto Implementation' },
      { 'gy',              function() Snacks.picker.lsp_type_definitions() end,  desc = 'Goto T[y]pe Definition' },
      { '<leader>ss',      function() Snacks.picker.lsp_symbols() end,           desc = 'LSP Symbols' },
      { '<leader>sS',      function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols' },
      { '<leader>.',       function() Snacks.scratch() end,                      desc = 'Toggle Scratch Buffer' },
      { '<leader>S',       function() Snacks.scratch.select() end,               desc = 'Select Scratch Buffer' },
      { '<leader>i',       function() Snacks.notifier.show_history() end,        desc = 'Notification History' },
      { '<leader>cR',      function() Snacks.rename.rename_file() end,           desc = 'Rename File' },
      { '<leader>gg',      function() Snacks.lazygit() end,                      desc = 'Lazygit' },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
          Snacks.toggle.diagnostics():map('<leader>ud')
          Snacks.toggle.treesitter():map('<leader>uT')
          Snacks.toggle.inlay_hints():map('<leader>uh')
          Snacks.toggle.indent():map('<leader>ug')
        end,
      })
    end,
  }
})

-- TODO: setup for markdown?
-- TODO: setup for bash?
-- TODO: linting?
-- TODO: status line
