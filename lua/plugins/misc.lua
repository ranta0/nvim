return {
  "tpope/vim-sleuth",

  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git, Config.remap_opt("[g]it [s]tatus", true))
    end,
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
      vim.opt.undodir = Config.undodir
    end,
  },

  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/Documents", "~/Downloads" },
        auto_session_root_dir = Config.sessiondir,
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
    end,
  },
}
