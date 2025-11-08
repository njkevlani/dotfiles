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

-- Copy content
function CopyFileContent() vim.cmd('%y+') end
vim.keymap.set('n', '<leader>cc', CopyFileContent, { desc = 'Copy file content to clipboard' })

-- Copy filename
function CopyFilename()
  local filename = vim.fn.expand('%:p')
  vim.fn.setreg('+', filename)
  vim.notify(string.format('Copied file name %s to clipboard.', filename), 'info')
end
vim.keymap.set('n', '<leader>cf', CopyFilename, { desc = 'Copy absolute file path' })

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Hungry backspace - eat more spaces if there is only spaces when pressing backspace.
vim.keymap.set('i', '<BS>', function()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local before = vim.api.nvim_get_current_line():sub(1, col):match('^%s*$')
  if before then
    -- https://www.reddit.com/r/neovim/comments/146gya4/comment/jnrl8lu/
    vim.cmd([[
      let g:exprvalue =
        \ (&indentexpr isnot '' ? &indentkeys : &cinkeys) =~? '!\^F'
        \ && &backspace =~? '.*eol\&.*start\&.*indent\&'
        \ && !search('\S', 'nbW', line('.'))
        \ ? (col('.') != 1 ? "\<C-U>" : "") . "\<bs>" . (getline(line('.')-1) =~ '\S' ? "" : "\<C-F>")
        \ : "\<bs>"
    ]])
    return vim.g.exprvalue
  else
    -- Default to auto-pairs backspace.
    return require('nvim-autopairs').autopairs_bs()
  end
end, { expr = true, noremap = true, replace_keycodes = false })

-- Run file
function RunFile()
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
end
vim.keymap.set('n', '<leader>rf', RunFile, { desc = 'Run current file' })

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

-- Settings up following rules for markdown files.
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

---@type LazyPluginSpec[]
local plugins = {
  { 'tpope/vim-sleuth' }, -- Detect tab / space automatically

  { 'tpope/vim-surround' }, -- Delete/change/add parentheses/quotes/much more with ease

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
    opts = {
      map_bs = false,
    },
  },

  {
    -- LSP for java
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    config = function()
      local home = os.getenv('HOME')
      local java_21_path = home .. '/.sdkman/candidates/java/21.0.6-amzn/bin/java'
      local lombok_jar = home
        .. '/.gradle/caches/modules-2/files-2.1/org.projectlombok/lombok/1.18.22/9c08ea24c6eb714e2d6170e8122c069a0ba9aacf/lombok-1.18.22.jar'
      local project_name = require('lspconfig.configs.jdtls').default_config.root_dir(vim.api.nvim_buf_get_name(0))

      -- Configs taken from https://github.com/mfussenegger/nvim-jdtls
      require('jdtls').start_or_attach({
        cmd = {
          java_21_path,
          '-javaagent:' .. lombok_jar,
          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xmx1g',
          '--add-modules=ALL-SYSTEM',
          '--add-opens',
          'java.base/java.util=ALL-UNNAMED',
          '--add-opens',
          'java.base/java.lang=ALL-UNNAMED',
          '-jar',
          '/opt/homebrew/Cellar/jdtls/1.47.0/libexec/plugins/org.eclipse.equinox.launcher_1.7.0.v20250424-1814.jar',
          '-configuration',
          '/opt/homebrew/Cellar/jdtls/1.47.0/libexec/config_mac_arm',
          '-data',
          '/tmp/jdtls/' .. project_name,
        },
        root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
      })
    end,
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
    },
  },

  {
    'neovim/nvim-lspconfig',
    init = function()
      ensure_installed({
        'gopls',
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
    'nvim-telescope/telescope.nvim',
    enabled = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      pickers = {
        live_grep = {
          additional_args = { '--hidden' },
        },
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`ed.
          find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
        },
      },
    },
    keys = {
      { '<leader>f', '<cmd>Telescope<cr>', desc = 'Telescope' },
      { '<leader>e', '<cmd>Telescope buffers<cr>', desc = 'Telescope Buffers' },
      { '<leader>n', '<cmd>Telescope live_grep<cr>', desc = 'Telescope Live Grep' },
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
    -----@module 'snacks'
    ---@type snacks.Config
    opts = {
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      picker = {
        enabled = true,
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
      { '<leader>p', function() Snacks.picker.resume() end, desc = 'Resume last picker' },
      { '<leader>n', function() Snacks.picker.grep() end, desc = 'Grep' },
      { '<leader>N', function() Snacks.picker.files() end, desc = 'Grep' },
      { '<leader>d', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics' },
      { '<leader>sh', function() Snacks.picker.help() end, desc = 'Help Pages' },
      { '<leader>?', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
      { '<leader>sq', function() Snacks.picker.qflist() end, desc = 'Quickfix List' },
      { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
      { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declaration' },
      {
        'gr',
        function() Snacks.picker.lsp_references() end,
        desc = 'References',
        nowait = true,
      },
      { '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
      { '<leader>S', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
      { '<leader>i', function() Snacks.notifier.show_history() end, desc = 'Notification History' },
      { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
      { '<leader>gi', function() Snacks.picker.gh_issue() end, desc = 'GitHub Issues (open)' },
      { '<leader>gI', function() Snacks.picker.gh_issue({ state = 'all' }) end, desc = 'GitHub Issues (all)' },
      { '<leader>gp', function() Snacks.picker.gh_pr() end, desc = 'GitHub Pull Requests (open)' },
      { '<leader>gP', function() Snacks.picker.gh_pr({ state = 'all' }) end, desc = 'GitHub Pull Requests (all)' },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...) Snacks.debug.inspect(...) end
          _G.bt = function() Snacks.debug.backtrace() end
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
  },

  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function() vim.fn['mkdp#util#install']() end,
    keys = {
      { '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Toggole NvimTree' },
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
    -- For aligning/format tables in markdown.
    'dhruvasagar/vim-table-mode',
    ft = { 'markdown' },
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
}

require('lazy').setup(plugins)
