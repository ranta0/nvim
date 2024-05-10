local utils = require("utils")

return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "╎" },
    },
  },

  "tpope/vim-sleuth",

  {
    "numToStr/Comment.nvim",
    opts = {},
  },

  {
    "j-hui/fidget.nvim",
    opts = {},
  },

  {
    "mbbill/undotree",
    keys = {
      {
        "<leader>u",
        "<CMD>UndotreeToggle<CR><CMD>UndotreeFocus<CR>",
        desc = "[u]ndotreeToggle",
      },
    },
    lazy = false,
    config = function()
      vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
    end,
  },

  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Documents", "~/Downloads", "/" },
        auto_session_root_dir = os.getenv("HOME") .. "/.vim/sessionsdir/",
      })
    end,
  },

  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = false,
      keymaps = {
        ["<C-t>"] = false,
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-r>"] = "actions.refresh",
      },
      view_options = {
        show_hidden = true,
      },
    },
    config = function(_, opts)
      require("oil").setup(opts)

      vim.keymap.set("n", "<leader>-", require("oil").toggle_float, utils.remap_opt("open parent dir", true))
    end,
  },
}
