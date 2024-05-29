Config.statusline_opts = function()
  local function section_git_head()
    local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
    if handle then
      local result = handle:read("*a")
      handle:close()
      return result:gsub("\n", "")
    else
      return ""
    end
  end

  local section_diff = function()
    local summary = vim.b.minidiff_summary_string
    if summary == nil then
      return ""
    end
    return string.format("%s", summary == "" and "-" or summary)
  end

  local statusline = require("mini.statusline")
  local _, mode_hl = statusline.section_mode({ trunc_width = 120 })
  local diagnostics = statusline.section_diagnostics({ trunc_width = 75, icon = "" })
  local filename = statusline.section_filename({ trunc_width = 140 })
  local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
  local search = statusline.section_searchcount({ trunc_width = 75 })

  return statusline.combine_groups({
    { hl = mode_hl, strings = { section_git_head() } },
    { hl = "MiniStatuslineDevinfo", strings = { section_diff(), diagnostics } },
    "%<", -- Mark general truncate point
    { hl = "MiniStatuslineFilename", strings = { filename } },
    "%=", -- End left alignment
    "[%n]",
    { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
    { hl = mode_hl, strings = { search } },
    " %P ",
  })
end

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
  keymap("sG", "<cmd>Pick grep_live<CR>", Config.remap_opt("[s]earch [G]rep live", true))
  keymap("sw", '<cmd>Pick grep pattern="<cword>"<CR>', Config.remap_opt("[s]earch grep current [w]ord", true))
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
      require("mini.trailspace").setup()
      require("mini.comment").setup()
      require("mini.misc").setup()
      require("mini.extra").setup()
      require("mini.visits").setup()

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

      require("mini.statusline").setup({
        content = {
          active = Config.statusline_opts,
        },
        use_icons = true,
      })

      require("mini.notify").setup({
        lsp_progress = {
          enable = true,
          duration_last = 1000,
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
