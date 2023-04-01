vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
  },

  "williamboman/mason.nvim",

  "williamboman/mason-lspconfig.nvim",

  "neovim/nvim-lspconfig",

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
  },

  "hrsh7th/cmp-path",

  "hrsh7th/cmp-cmdline",

  "L3MON4D3/LuaSnip",

  "saadparwaiz1/cmp_luasnip",

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      pcall(require("nvim-treesitter.install").update { with_sync = true })
    end,
  },

  "nvim-treesitter/nvim-treesitter-context",

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    opts = {
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
    },
  },

  "folke/neodev.nvim",

  { "nvim-telescope/telescope.nvim", version = "*", dependencies = { "nvim-lua/plenary.nvim" } },

  { "numToStr/Comment.nvim", opts = {} },

  "nvim-lualine/lualine.nvim",

  "tpope/vim-sleuth",

  "lewis6991/gitsigns.nvim",

  "tpope/vim-fugitive",

  "tpope/vim-rhubarb",

  { "j-hui/fidget.nvim", opts = {} },

  {
    "iamcco/markdown-preview.nvim",
    event = "BufRead",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  "vimwiki/vimwiki",

  "junegunn/vim-easy-align",

  "christoomey/vim-tmux-navigator",
})
