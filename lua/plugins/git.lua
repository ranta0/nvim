local utils = require "utils"

return {
  "tpope/vim-fugitive",

  "tpope/vim-rhubarb",

  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      current_line_blame = true,
    },
    config = function(_, opts)
      local gitsigns = require "gitsigns"
      gitsigns.setup(opts)

      vim.keymap.set("n", "]h", gitsigns.next_hunk, utils.remap_opt("git next hunk", true))
      vim.keymap.set("n", "[h", gitsigns.prev_hunk, utils.remap_opt("git previous hunk", true))
      vim.keymap.set("n", "<leader>gg", gitsigns.diffthis, utils.remap_opt("[g]it diff current file", true))
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git, utils.remap_opt("[g]it [s]tatus", true))
    end,
  },
}
