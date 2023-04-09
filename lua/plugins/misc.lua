local utils = require("utils")

return {
    "tpope/vim-sleuth",

    { "j-hui/fidget.nvim", opts = {} },

    {
        "iamcco/markdown-preview.nvim",
        event = "BufRead",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        keys = {
            {
                "<leader>mp",
                "<CMD>MarkdownPreviewToggle<CR>",
                desc = "[m]arkDown [p]review"
            }
        }
    },

    {
        "junegunn/vim-easy-align",
        cmd = "EasyAlign",
        keys = {
            {
                "<leader>ga",
                mode = "v",
                "<CMD>EasyAlign<CR>",
                desc = "align columns"
            }
        }
    },

    {
        "mbbill/undotree",
        keys = {
            {
                "<leader>u",
                "<CMD>UndotreeToggle<CR><CMD>UndotreeFocus<CR>",
                desc = "[u]ndotreeToggle"
            }
        },
        config = function ()
            vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
        end
    },

    {
        "NvChad/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = {
            filetypes = { "*" },
            user_default_options = {
                RGB = true,
                RRGGBB = true,
                names = true,
                RRGGBBAA = true,
                AARRGGBB = false,
                rgb_fn = true,
                hsl_fn = true,
                css = true,
                css_fn = true,
                mode = "background",
                tailwind = true,
                virtualtext = "■",
            },
        },
    },

    "christoomey/vim-tmux-navigator",
}
