return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = function()
    return {
      defaults = {
        mappings = {
          i = {
            ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
            ["<C-q>"] = require("telescope.actions").send_to_qflist,
          },
        },
        preview = {
          -- hide previewer when picker starts
          hide_on_startup = true,
        },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope")

    telescope.setup(opts)
    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>?", builtin.oldfiles, Config.remap_opt("find recently opened files", true))
    vim.keymap.set("n", "<leader>sf", builtin.find_files, Config.remap_opt("[s]earch [f]iles", true))
    vim.keymap.set(
      "n",
      "<leader>sh",
      "<CMD>Telescope find_files hidden=true<CR>",
      Config.remap_opt("[s]earch [h]idden", true)
    )
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, Config.remap_opt("[s]earch by [g]rep", true))
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, Config.remap_opt("[s]earch current [w]ord", true))

    -- override default spell_suggest
    vim.keymap.set("n", "z=", "<CMD>silent Telescope spell_suggest<CR>", Config.remap_opt("spell suggestion", true))

    -- diagnostics
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, Config.remap_opt("[s]earch [d]iagnostics", true))
  end,
}
