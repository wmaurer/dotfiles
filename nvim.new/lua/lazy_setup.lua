vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup {
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
    opts = function(_, opts) opts.ensure_installed = { "lua_ls" } end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    opts = function(_, opts) opts.ensure_installed = { "stylua", "selene" } end,
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
  { "hrsh7th/nvim-cmp" },
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
