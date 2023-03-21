local present, gitsigns = pcall(require, "gitsigns")

if not present then
    return
end

gitsigns.setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = '┆' },
    },
    current_line_blame = true,
})

local utils = require("utils")
vim.keymap.set("n", "]h", gitsigns.next_hunk,
    utils.remap_opt("git next hunk",true)
)
vim.keymap.set("n", "[h", gitsigns.prev_hunk,
    utils.remap_opt("git previous hunk",true)
)
