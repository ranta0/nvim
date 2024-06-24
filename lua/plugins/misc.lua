return {
  "tpope/vim-sleuth",

  -- install it if missing
  { "junegunn/fzf", build = "./install --bin" },

  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git, Config.remap_opt("[g]it [s]tatus", true))
    end,
  },

  {
    "ibhagwan/fzf-lua",
    config = function()
      require("fzf-lua").setup({})

      vim.keymap.set(
        "n",
        "<leader>sd",
        "<cmd>FzfLua lsp_document_diagnostics<CR>",
        Config.remap_opt("[s]earch [d]iagnostcs", true)
      )
      vim.keymap.set(
        "n",
        "<leader>sD",
        "<cmd>FzfLua lsp_workspace_diagnostics<CR>",
        Config.remap_opt("[s]earch [D]iagnostcs", true)
      )
      vim.keymap.set("n", "<leader>sf", "<cmd>FzfLua files<CR>", Config.remap_opt("[s]earch [f]files", true))
      vim.keymap.set("n", "<leader>?", "<cmd>FzfLua oldfiles<CR>", Config.remap_opt("search oldfiles", true))
      vim.keymap.set("n", "<leader><leader>", "<cmd>FzfLua buffers<CR>", Config.remap_opt("search buffers", true))
      vim.keymap.set("n", "<leader>sl", "<cmd>FzfLua live_grep<CR>", Config.remap_opt("grep [l]ive", true))

      vim.keymap.set("n", "z=", "<cmd>FzfLua spell_suggest<CR>", Config.remap_opt("spell suggest", true))

      vim.keymap.set("i", "<C-x><C-f>", function()
        require("fzf-lua").complete_path()
      end, Config.remap_opt("fuzzy complete path", true))
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
      vim.o.undofile = true
      vim.opt.undodir = Config.undodir
    end,
  },

  {
    "francoiscabrol/ranger.vim",
    dependencies = {
      "rbgrouleff/bclose.vim",
    },
    keys = {
      {
        "<leader>f",
        "<cmd>Ranger<CR>",
        desc = "open Ranger",
      },
    },
  },

  {
    "skanehira/vsession",
    config = function()
      vim.g.vsession_save_last_on_leave = 1
      if vim.fn.isdirectory(Config.sessiondir) == 0 then
        vim.fn.mkdir(Config.sessiondir)
      end
      vim.g.vsession_path = Config.sessiondir
    end,
  },
}
