vim.g.mapleader = ' '

vim.opt.number = true

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

vim.opt.termguicolors = true

vim.keymap.set('n', '<Esc>', '<CMD>nohlsearch<CR>', { desc = '<ESC> will also clear highlights' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<leader>h', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>l', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>j', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>k', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Better indenting in visual mode.
vim.keymap.set('v', '<', '<gv', { desc = 'Stay in visual mode after indenting in visual mode' })
vim.keymap.set('v', '>', '>gv', { desc = 'Stay in visual mode after indenting in visual mode' })

vim.keymap.set('n', '<leader>q', '<CMD>bd<CR>', { desc = 'Buffer delete' })

vim.keymap.set('n', '<leader>/', 'gccj', { remap = true, desc = 'Comment current line and move down' })
vim.keymap.set('v', '<leader>/', 'gc', { remap = true, desc = 'Comment current selection' })

-- surround
vim.keymap.set('v', '(', 'c(<ESC>pa)<ESC>')
vim.keymap.set('v', "'", "c'<ESC>pa'<ESC>")
vim.keymap.set('v', '"', 'c"<ESC>pa"<ESC>')

-- Disable annoying/unused keymappings.
vim.keymap.set('n', 'q:', '<Nop>')

-- Copy content
vim.api.nvim_create_user_command(
  'CopyFileContent',
  function() vim.cmd('%y+') end,
  { desc = 'Copy file content to clipboard' }
)

vim.keymap.set('n', '<leader>cc', '<CMD>CopyFileContent<CR>', { desc = 'Copy file content to clipboard' })

-- Copy filename
vim.api.nvim_create_user_command('CopyFilename', function()
  local filename = vim.fn.expand('%:p')
  vim.fn.setreg('+', filename)
  vim.notify(string.format('Copied file name %s to clipboard.', filename), 'info')
end, { desc = 'Copy absolute file path' })

vim.keymap.set('n', '<leader>cf', '<CMD>CopyFilename<CR>', { desc = 'Copy absolute file path' })

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Run file
vim.api.nvim_create_user_command('RunFile', function()
  local run_cmds = {
    python = 'python',
    sh = 'bash',
    go = 'go run',
    rust = 'cargo run',
  }

  local ft = vim.bo.filetype
  local file = vim.fn.expand('%')
  local cmd = run_cmds[ft]

  if not cmd then
    print('No run command defined for filetype: ' .. ft)
    return
  end

  local run_cmd = cmd .. ' ' .. file

  vim.notify('Running ' .. run_cmd)

  vim.cmd('vs | terminal ' .. run_cmd)
end, { desc = 'Run current file' })

vim.keymap.set('n', '<leader>rf', '<CMD>RunFile<CR>', { desc = 'Run current file' })

-- Go to last location when opening a buffer
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

-- This makes sure cursorHold triggered sooner.
vim.opt.updatetime = 500
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float({
      border = 'rounded',
      source = true,
      scope = 'cursor',
      focus = false,
    })
  end,
})

local function ensure_installed(binaries_required)
  for _, cmd in ipairs(binaries_required) do
    if vim.fn.executable(cmd) == 0 then
      require('snacks').notify.warn('Command not found: ' .. cmd)
    end
  end
end

-- Settings up following rules for Markdown files.
-- - New line after 80 chars in current line.
-- - Show column line at col 80.
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.colorcolumn = { 80 }
  end,
})

-- Open scratch buffer
vim.keymap.set('n', '<leader>.', function()
  Snacks.picker.select(
    {
      { name = 'json', ft = 'json' },
      { name = 'markdown', ft = 'md' },
      { name = 'shell', ft = 'sh' },
      { name = 'python', ft = 'py' },
      { name = 'golang', ft = 'go' },
      { name = 'yaml', ft = 'yaml' },
    },
    { prompt = 'Create or open scratch buffer', format_item = function(item) return item.name end },
    function(selected, _)
      if selected then
        vim.cmd('edit ' .. vim.fn.stdpath('data') .. '/scratch/scratch.' .. selected.ft)
      end
    end
  )
end, { desc = 'Select scratch buffers' })

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.HINT] = ' ',
    },
    priority = 2,
  },
})

-- Install `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

---@type LazyPluginSpec[]
local plugins = {
  { 'tpope/vim-sleuth' }, -- Detect tab / space automatically

  {
    -- Delete/change/add parentheses/quotes/much more with ease
    'tpope/vim-surround',
    enabled = false,
  },

  {
    -- For git signs
    'echasnovski/mini.diff',
    opts = {
      view = {
        style = 'sign',
        priority = 1,
      },
    },
  },

  {
    -- For auto close parentheses
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
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
        documentation = {
          auto_show = true,
          window = { border = 'rounded' },
        },
      },
      cmdline = {
        completion = {
          list = {
            selection = {
              -- With preselect = true, selecting first entry is not straightforward.
              -- On pressing Tab, the 2nd entry is selected.
              -- On pressing enter, currently typed input is sent as command.
              preselect = false,
            },
          },
        },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    init = function()
      ensure_installed({
        'gopls',
        'golangci-lint',
        'golangci-lint-langserver',
        'harper-ls',
        'stylua',
        'lua-language-server',
        'pyright-langserver',
        'yaml-language-server',
        'bash-language-server',
        'protols',
      })
    end,
    config = function()
      vim.lsp.enable('gopls')
      vim.lsp.enable('golangci_lint_ls')
      vim.lsp.enable('harper_ls')
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('pyright')
      vim.lsp.enable('yamlls')
      vim.lsp.enable('bashls')
      vim.lsp.enable('protols')

      vim.lsp.config('protols', {
        -- In some projects, we use `proto` directory as root.
        root_markers = { 'proto' },
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function()
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[LSP] Go to definition' })
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[LSP] Rename' })
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[LSP] Code Actions' })
        end,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local configs = require('nvim-treesitter.configs')

      ---@diagnostic disable-next-line: missing-fields
      configs.setup({
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<leader>w',
            node_incremental = 'w',
            scope_incremental = false,
            node_decremental = 'W',
          },
        },

        ensure_installed = {
          'go',
          'bash',
          'python',
          'diff',
          'dockerfile',
          'jsonnet',
          'just',
          'markdown',
          'markdown_inline',
          'scala',
          'sql',
          'yaml',
          'lua',
          'html',
          'css',
          'vimdoc',
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  {
    -- For formatting
    'stevearc/conform.nvim',
    init = function()
      ensure_installed({
        'golangci-lint',
        'goimports',
        'gci',
        'gofumpt',
        'markdownlint-cli2',
        'shellcheck',
        'jq',
        'dockerfmt',
        'tombi',
      })
    end,
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        go = {
          'goimports', -- removal of unused imports
          'gci', -- better ordering of imports
          'gofumpt', -- formatting in general
        },
        markdown = { 'markdownlint-cli2' },
        sh = { 'shellcheck', 'shfmt' },
        zsh = { 'shfmt' },
        json = { 'jq' },
        toml = { 'tombi' },
        dockerfile = { 'dockerfmt' },
      },
      format_on_save = {
        timeout_ms = 5000,
      },
      formatters = {
        gci = {
          prepend_args = {
            -- Order for sorting imports
            '-s',
            'standard', -- Std packages first.
            '-s',
            'default', -- Then packages that do not match any group.
            '-s',
            'localmodule', -- Then local packages.
          },
        },
      },
    },
  },

  {
    'zenbones-theme/zenbones.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    lazy = false,
    config = function()
      vim.opt.background = 'light'
      vim.cmd.colorscheme('seoulbones')
      vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { bg = '#AAAAAA', bold = true })
    end,
  },

  {
    'mcauley-penney/visual-whitespace.nvim',
    config = true,
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
    dependencies = 'nvim-tree/nvim-web-devicons',
    -----@module 'snacks'
    ---@type snacks.Config
    opts = {
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      picker = {
        enabled = true,
        layout = 'select',
        win = {
          input = {
            keys = {
              ['<S-CR>'] = { 'edit_vsplit', mode = { 'i', 'n' } },
            },
          },
        },
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
      scratch = {
        filekey = {
          cwd = false,
          branch = false,
          count = false,
        },
      },
    },
    keys = {
      { '<leader>1', function() Snacks.explorer() end, desc = 'File Explorer' },
      { '<leader>rp', function() Snacks.picker.resume() end, desc = 'Resume last picker' },
      { '<leader>p', function() Snacks.picker() end, desc = 'Snacks pickers' },
      { '<leader>n', function() Snacks.picker.grep({ layout = 'vertical' }) end, desc = 'Grep' },
      { '<leader>N', function() Snacks.picker.files() end, desc = 'Find Files' },
      { '<leader>d', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics' },
      { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
      { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declaration' },
      {
        'gr',
        function() Snacks.picker.lsp_references() end,
        desc = 'LSP References',
        nowait = true,
      },
      { '<leader>i', function() Snacks.notifier.show_history() end, desc = 'Notification History' },
      { '<leader>uw', function() Snacks.toggle.option('wrap', { name = 'Wrap' }) end, desc = 'Toogle Wrap' },
    },
  },

  {
    'brianhuster/live-preview.nvim',
    dependencies = {
      'folke/snacks.nvim',
    },
  },

  {
    'bullets-vim/bullets.vim',
    ft = { 'markdown' },
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        -- Override Markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
        hover = {
          enabled = true,
          silent = false, -- set to true to not show a message if hover is not available
          view = nil, -- when nil, use defaults from documentation
          opts = {}, -- merged with defaults from documentation
        },
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
            luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
            throttle = 50, -- Debounce LSP signature help request by 50 milliseconds
          },
          view = nil, -- when nil, use defaults from documentation
          opts = {}, -- merged with defaults from documentation
        },
      },
      -- You can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- Use a classic bottom cmdline for search
        command_palette = true, -- Position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- Enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- Add a border to hover docs and signature help
      },
      views = {
        cmdline_popup = {
          position = {
            row = '10%',
          },
        },
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },

  {
    -- Highlight work currently under the cursor at other places as well.
    'RRethy/vim-illuminate',
  },

  {
    -- Merge conflict resolver.
    'sindrets/diffview.nvim',
  },

  {
    -- Show diagnostic count at top right corner.
    'b0o/incline.nvim',
    config = function()
      require('incline').setup({
        render = function(props)
          local status_elements = {}

          -- Collect diagnostic labels.
          local icons = { error = ' ', warn = ' ', info = ' ', hint = ' ' }
          local diagnostic_label = {}

          for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
            if n > 0 then
              table.insert(diagnostic_label, { icon .. n .. ' ', group = 'DiagnosticSign' .. severity })
            end
          end

          if #diagnostic_label > 0 then
            table.insert(status_elements, diagnostic_label)
          end

          -- Collect LSP servers attached.
          local lsp_clients = vim.lsp.get_clients({ bufnr = 0 })
          local lsp_client_names = {}
          for _, client in ipairs(lsp_clients) do
            table.insert(lsp_client_names, client.name)
          end

          if #lsp_clients > 0 then
            table.insert(status_elements, { ' ' .. table.concat(lsp_client_names, ', '), group = 'Keyword' })
          end

          return status_elements
        end,
      })
    end,
  },

  {
    -- Highlights color codes with their actual color (like black color for #000).
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end,
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      preset = 'helix',
      filter = function(mapping)
        -- Mapping which I do not want to see.
        local hidden = {
          ['<leader>h'] = true,
          ['<leader>l'] = true,
          ['<leader>j'] = true,
          ['<leader>k'] = true,
          ['b'] = true,
          ['B'] = true,
          ['h'] = true,
          ['j'] = true,
          ['l'] = true,
          ['k'] = true,
        }
        return not hidden[mapping.lhs]
      end,
    },
    keys = function()
      local wk = require('which-key')
      return {
        { '<leader>?', function() wk.show() end, desc = 'Which Key' },
        { '<C-/>', function() wk.show() end, mode = 'i', desc = 'Which Key' },
      }
    end,
  },

  {
    -- Ensure that yaml-language-server does not kick in when editing helm file.
    'towolf/vim-helm',
    ft = 'helm',
  },

  {
    'ramilito/kubectl.nvim',
    version = '2.*',
    dependencies = 'saghen/blink.download',
    config = true,
  },

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'leoluz/nvim-dap-go',
        opts = {},
      },
      {
        'igorlfs/nvim-dap-view',
        lazy = false,
        version = '1.*',
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = {
          winbar = {
            show = true,
            controls = {
              enabled = true,
              buttons = { 'play', 'step_over', 'step_into', 'run_last', 'terminate' },
            },
          },
        },
      },
    },
    keys = {
      { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'Toogle breakpoint' },
    },
    config = function()
      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticError' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DiagnosticWarn' })
      vim.fn.sign_define('DapStopped', { text = '', texthl = 'DiagnosticError', linehl = 'DapStoppedLine' })
    end,
  },
}

require('lazy').setup(plugins)
