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
        "<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>",
        desc = "[u]ndotreeToggle",
      },
    },
    lazy = false,
    config = function()
      vim.opt.undodir = Config.undodir
    end,
  },

  {
    "skanehira/vsession",
    config = function()
      vim.g.vsession_save_last_on_leave = 1
      vim.g.vsession_path = Config.sessiondir
    end,
  },

  {
    "stevearc/oil.nvim",
    keys = {
      {
        "<leader>ef",
        "<cmd>Oil<CR>",
        desc = "[e]xplore [f]ile",
      },
    },
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
