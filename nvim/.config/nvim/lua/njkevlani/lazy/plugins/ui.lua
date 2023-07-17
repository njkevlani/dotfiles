return {
  -- Colorscheme.
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    config = function()
      require("github-theme").setup({})

      vim.cmd("colorscheme github_light")

      -- highlight group for lsp signature help can be better in github theme.
      vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { fg = "#111111", bold = true })
    end,
  },

  -- Preview of keymap.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.timeout = true
      vim.opt.timeoutlen = 300
    end,
    opts = {}
  },

  -- General purpose fuzzy finder.
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
      })
    end,
    keys = {
      { "<leader>tt", "<cmd>Telescope<cr>",            desc = "Show all telescope pickers" },
      { "<leader>tr", "<cmd>Telescope resume<cr>",     desc = "Resume last search in telescope" },
      { "<leader>tg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep telescope picker" },
      { "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Find files telescope picker" },
    },
  },

  -- UI for messages, cmdline and the popupmenu.
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>",              desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>",             desc = "Quickfix List (Trouble)" },
    },
  },

  -- Indent lines
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "│",
      show_current_context = false, -- using mini.indentscope for this functionality.
      show_trailing_blankline_indent = false,
    },
  },

  -- Highlight indent based on block scope.
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
  },

  -- Set lualine as statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          { "filetype", icon_only = true, separator = "" },
          { "filename", path = 1 },
        },
        lualine_x = {
          "encoding",
          -- Current files uses tabs? spaces? or mixed?
          -- Taken from https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets
          function()
            local space_pat = [[\v^ +]]
            local tab_pat = [[\v^\t+]]
            local space_indent = vim.fn.search(space_pat, "nwc")
            local tab_indent = vim.fn.search(tab_pat, "nwc")
            local mixed = (space_indent > 0 and tab_indent > 0)
            local mixed_same_line
            if not mixed then
              mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], "nwc")
              mixed = mixed_same_line > 0
            end

            if not mixed then
              if space_indent > 0 then
                return vim.opt.shiftwidth:get() .. " Spaces"
              end

              if tab_indent > 0 then
                return "Tabs"
              end

              return "unknown indent"
            end

            if mixed_same_line ~= nil and mixed_same_line > 0 then
              return "Mixed Indent:" .. mixed_same_line
            end
            local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
            local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
            if space_indent_cnt > tab_indent_cnt then
              return "Mixed Indent:" .. tab_indent
            else
              return "Mixed Indent:" .. space_indent
            end
          end
        },
        lualine_y = { "progress" },
        lualine_z = {
          -- Hex value of the char under cursor.
          { "%04B", fmt = function(value) return string.format("[0x%s]", value) end, separator = "@" },
          "location",
        },
      },
    },
  },

  -- Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
