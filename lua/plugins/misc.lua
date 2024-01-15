local utils = require("utils")

return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {}
    },

    "tpope/vim-sleuth",

    {
        "numToStr/Comment.nvim",
        opts = {}
    },

    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        opts = {}
    },

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
                ":LiveEasyAlign<CR>",
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

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            vim.keymap.set("n", "<leader>nb", ":Neotree buffers reveal float<CR>",
                utils.remap_opt("[n]eotree [b]uffers",true)
            )
            vim.keymap.set("n", "<leader>nt", ":Neotree toggle<CR>",
                utils.remap_opt("[n]eotree [t]oggle",true)
            )
        end,
    }
}
