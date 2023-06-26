-- Editing, Completion, Formatting, Diagnostic, etc.

local lsps_to_configure = {
  "gopls",  -- golang
  "lua_ls", -- lua
  "bashls", -- bash
  "ltex",   -- writing, spellchecks.
}

return {
  -- Highlight, edit, and navigate code
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/playground",
    },
    build = ":TSUpdate",
    opt = {
      ensure_installed = {
        "go", "gomod", "gowork", "gosum", "lua", "python", "rust", "vimdoc", "vim", "bash", "markdown", "regex",
        "markdown_inline", "json", "json5", "jsonc",
      },

      highlight = { enable = true },

      indent = { enable = true },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>w",
          node_incremental = "<leader>w",
          scope_incremental = false,
          node_decremental = "<leader>W",
        },
      },
    },
  },

  -- LSP config.
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      for _, lsp in ipairs(lsps_to_configure) do
        lspconfig[lsp].setup({})
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local function merge(...)
            return vim.tbl_extend("force", ...)
          end

          -- Buffer local mappings.
          local opts = { buffer = ev.buf }
          local keymap = vim.keymap.set
          keymap("n", "gD", vim.lsp.buf.declaration, merge(opts, { desc = "[LSP] go to declaration" }))
          keymap("n", "gd", vim.lsp.buf.definition, merge(opts, { desc = "[LSP] go to definition" }))
          keymap("n", "K", vim.lsp.buf.hover, opts)
          keymap("n", "gi", "<cmd>TroubleToggle lsp_implementations<cr>", merge(opts, { desc = "[LSP] go to implementations" }))
          keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          keymap("n", "<leader>D", vim.lsp.buf.type_definition, merge(opts, { desc = "[LSP] go to definition of type" }))
          keymap("n", "<leader>rn", vim.lsp.buf.rename, merge(opts, { desc = "[LSP] raname" }))
          keymap("n", "<leader>ca", "<cmd>CodeActionMenu<cr>", merge(opts, { desc = "[LSP] suggest code actions" }))
          keymap("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", merge(opts, { desc = "[LSP] go to references" }))

          -- On mouse click, do the mouse click and show diagnostics.
          -- Ideally would want to show diagnostic on mouse hover, but could not find somethign that does it.
          keymap("n", "<LeftMouse>", "<LeftMouse><cmd>lua vim.diagnostic.open_float()<cr>", opts)
          keymap("n", "[d", vim.diagnostic.goto_prev, merge(opts, { desc = "go to previous diagnostic" }))
          keymap("n", "]d", vim.diagnostic.goto_next, merge(opts, { desc = "go to next diagnostic" }))

          -- Toggle formatting.
          local formatting_enabled = true
          keymap("n", "<leader>f", function()
            formatting_enabled = not formatting_enabled
            vim.notify("Formatting toggled, formatting_enabled = " .. tostring(formatting_enabled), vim.log.levels.INFO)
          end, merge(opts, { desc = "Toggle auto formatting on save" }))

          -- Auto format on save.
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormatting", {}),
            buffer = ev.buf,
            callback = function()
              if formatting_enabled then
                vim.lsp.buf.format()
              else
                vim.notify("Auto formatting on save is disbled", vim.log.levels.WARN)
              end
            end,
          })
        end,
      })

      -- Do not show virtual/ghost text on diagnostic errors.
      vim.diagnostic.config({
        virtual_text = false,
      })
    end,
    dependencies = {
      -- LSP goodness in nvim config.
      {
        "folke/neodev.nvim",
        config = function()
          require("neodev").setup()
        end,
      },

      -- Better code actions menu.
      {
        "weilbith/nvim-code-action-menu",
      },
    },
  },

  -- null-ls: for linters/diagnostics, code actions.
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- writing.
          null_ls.builtins.completion.spell,
          null_ls.builtins.diagnostics.write_good,
          null_ls.builtins.code_actions.proselint,
          null_ls.builtins.diagnostics.proselint,

          -- golang
          null_ls.builtins.code_actions.gomodifytags,
          null_ls.builtins.code_actions.impl,
          null_ls.builtins.code_actions.refactoring,
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.diagnostics.gospel,
          null_ls.builtins.diagnostics.revive,
          null_ls.builtins.diagnostics.semgrep,
          null_ls.builtins.diagnostics.staticcheck,
          null_ls.builtins.formatting.gofumpt,

          -- shell
          null_ls.builtins.code_actions.shellcheck,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.formatting.shfmt,
        },
      })
    end
  },

  {
    "onsails/lspkind.nvim",
    config = function()
      require("lspkind").init({})
    end
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Sources
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-cmdline",

      -- Formatting for nvim-cmp popup.
      "onsails/lspkind.nvim",

      -- Snipet engine.
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip").setup({})
        end,
        dependencies = { "rafamadriz/friendly-snippets" },
      },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              buffer = "[Buffer]",
              path = "[Path]",
            })
          }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      for _, lsp in ipairs(lsps_to_configure) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end
    end
  },

  {
    "jakewvincent/mkdnflow.nvim",
    ft = "markdown",
    config = function()
      require('mkdnflow').setup({
        mappings = {
          -- auto new number / bullet for list.
          -- go to next row in tables on pressing <cr>
          MkdnEnter = { { 'i', 'n', 'v' }, '<CR>' },
        }
      })
    end,
  },

  -- Delete or change or add brackets, quoats, etc.
  {
    "tpope/vim-surround",
  },

  -- Heuristically set buffer options
  {
    "tpope/vim-sleuth",
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
    keys = {
      { "<leader>/", "gccj", mode = "n", desc = "Toggle comment for line",      remap = true },
      { "<leader>/", "gc",   mode = "v", desc = "Toggle comment for selection", remap = true },
    },
  },

  -- Auto close brackets.
  {
    "echasnovski/mini.pairs",
    config = true,
  },
}
