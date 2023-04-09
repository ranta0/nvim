local utils = require("utils")

return {
    "tpope/vim-fugitive",

    "tpope/vim-rhubarb",

    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = '┆' },
            },
            current_line_blame = true,
        },
        config = function(_,opts)
            local gitsigns = require("gitsigns")
            gitsigns.setup(opts)

            vim.keymap.set("n", "]h", gitsigns.next_hunk,
                utils.remap_opt("git next hunk",true)
            )
            vim.keymap.set("n", "[h", gitsigns.prev_hunk,
                utils.remap_opt("git previous hunk",true)
            )
        end
    }
}
