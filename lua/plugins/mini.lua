return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.completion").setup()
    require("mini.bracketed").setup()
    require("mini.comment").setup()
    require("mini.extra").setup()

    require("mini.statusline").setup({
      use_icons = false,
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

    -- use base16 colours
    vim.cmd("colorscheme onedark-revisited")
  end,
}
