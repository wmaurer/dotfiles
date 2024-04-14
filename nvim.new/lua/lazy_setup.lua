vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup {
  { "AstroNvim/astrocore", lazy = true },
  { "AstroNvim/astroui", lazy = true },
  {
    "rebelot/heirline.nvim",
    event = "BufEnter",
    dependencies = {
      "AstroNvim/astroui",
      "AstroNvim/astrocore",
    },
    config = function()
      local status = require "astroui.status"
      require("heirline").setup {
        statusline = {
          hl = { fg = "fg", bg = "bg" },
          status.component.mode(),
        },
      }
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<Leader>o", "<cmd>Neotree focus<cr>", desc = "Focus NeoTree" },
    },
    opts = function()
      local opts = {
        popup_border_style = "rounded",
        window = {
          mappings = {
            -- copied from AstroNvim
            ["h"] = function(state)
              local node = state.tree:get_node()
              if node:has_children() and node:is_expanded() then
                state.commands.toggle_node(state)
              else
                require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
              end
            end,
            -- copied from AstroNvim
            ["l"] = function(state)
              local node = state.tree:get_node()
              if node:has_children() then
                if not node:is_expanded() then -- if unexpanded, expand
                  state.commands.toggle_node(state)
                else -- if expanded and has children, select the next child
                  if node.type == "file" then
                    state.commands.open(state)
                  else
                    require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
                  end
                end
              else -- if has no children
                state.commands.open(state)
              end
            end,
          },
        },
      }
      return opts
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "angular",
          "astro",
          "c",
          "css",
          "diff",
          "dockerfile",
          "fish",
          "gitignore",
          "javascript",
          "jsdoc",
          "json",
          "lua",
          "luap",
          "prisma",
          "query",
          "rust",
          "scss",
          "sql",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = true,
        enabled = vim.fn.executable "make" == 1,
        build = "make",
      },
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "williamboman/mason.nvim",
    config = function() require("mason").setup() end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = {
        "lua_ls",
        "tsserver",
      }
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    opts = function(_, opts) opts.ensure_installed = { "stylua", "selene", "prettierd" } end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts) require("luasnip").config.set_config(opts) end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      local cmp = require "cmp"

      return {
        completion = {
          completeopt = "menu,menuone",
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        snippet = {
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },

        -- formatting = formatting_style,

        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<Up>"] = cmp.mapping.select_prev_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<Down>"] = cmp.mapping.select_next_item(),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<Esc>"] = cmp.mapping.close(),
          ["<Enter>"] = cmp.mapping.confirm(),
        },

        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "nvim_lua" },
          { name = "path" },
        },
      }
    end,
    config = function(_, opts) require("cmp").setup(opts) end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
}

vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.o.clipboard = "unnamedplus"
vim.cmd.colorscheme "catppuccin"

vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

vim.api.nvim_set_keymap("n", "<Leader>c", "<Cmd>confirm bdelete<CR>", { desc = "Close buffer" })
vim.api.nvim_set_keymap("n", "<Leader>w", "<Cmd>w<CR>", { desc = "Save" })
vim.api.nvim_set_keymap("n", "<Leader>q", "<Cmd>confirm q<CR>", { desc = "Quit Window" })
vim.api.nvim_set_keymap("n", "<Leader>Q", "<Cmd>confirm qall<CR>", { desc = "Exit AstroNvim" })
vim.api.nvim_set_keymap("n", "<Leader>n", "<Cmd>enew<CR>", { desc = "New File" })

-- vim.api.nvim_set_keymap("n", "<Leader>la", "cccccccckkckkccccc:cccccc     cccccccckkckkccccc

--vim.lsp.buf.code_action() end, { desc = "LSP code action" })
