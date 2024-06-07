Config.pick_keymaps = function()
  local keymap = function(suffix, rhs, opts)
    vim.keymap.set("n", "<leader>" .. suffix, rhs, opts)
  end

  keymap("ec", '<cmd>lua MiniFiles.open(vim.fn.stdpath("config"))<CR>', Config.remap_opt("[e]xplore [c]onfig", true))
  keymap("ed", "<cmd>lua MiniFiles.open()<CR>", Config.remap_opt("[e]xplore [d]irectory", true))

  keymap("sd", '<cmd>Pick diagnostic scope="all"<CR>', Config.remap_opt("[s]earch diagnostcs", true))
  keymap("sD", '<cmd>Pick diagnostic scope="current"<CR>', Config.remap_opt("[s]earch [D]iagnostic buffer", true))
  keymap("sf", "<cmd>Pick files<CR>", Config.remap_opt("[s]earch [f]iles", true))
  keymap("sh", "<cmd>Pick git_files<CR>", Config.remap_opt("[s]earch files [h]idden", true))
  keymap("sl", "<cmd>Pick grep_live<CR>", Config.remap_opt("[s]earch grep [l]ive", true))
  keymap("?", '<cmd>Pick visit_paths cwd=""<CR>', Config.remap_opt("Visit paths (all)", true))
  keymap("<leader>", "<cmd>Pick buffers<CR>", Config.remap_opt("Buffers", true))

  vim.keymap.set("n", "z=", "<cmd>Pick spellsuggest<CR>", Config.remap_opt("spell suggestion", true))
end

return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.completion").setup()
      require("mini.bracketed").setup()
      require("mini.comment").setup()
      require("mini.extra").setup()
      require("mini.visits").setup()

      require("mini.statusline").setup({
        use_icons = false,
      })

      require("mini.indentscope").setup({
        draw = {
          animation = function()
            return 1
          end,
        },
      })

      require("mini.files").setup({
        content = { prefix = function() end },
        options = {
          use_as_default_explorer = false,
        },
      })

      local pick = require("mini.pick")
      pick.setup({
        source = { show = pick.default_show },
        mappings = {
          move_down = "<C-j>",
          move_up = "<C-k>",
        },
      })

      require("mini.diff").setup({
        view = {
          style = "sign",
          signs = { add = "+", change = "~", delete = "_" },
          priority = 199,
        },
      })

      local hipatterns = require("mini.hipatterns")
      local hi_words = require("mini.extra").gen_highlighter.words
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
          hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
          todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
          note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),

          -- Highlight hex color strings (`#008080`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

      Config.pick_keymaps()

      -- use base16 colours
      vim.cmd("colorscheme onedark-revisited")
    end,
  },
}
