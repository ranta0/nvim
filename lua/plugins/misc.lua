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
        'stevearc/oil.nvim',
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
        },
        config = function ()
            local opts = {
                default_file_explorer = false,
                keymaps = {
                    ["<C-t>"] = false,
                    ["<C-h>"] = false,
                    ["<C-l>"] = false,
                    ["<C-r>"] = "actions.refresh",
                },
            }
            require("oil").setup(opts)

            vim.keymap.set("n", "<leader>-", require("oil").open,
                utils.remap_opt("open parent dir",true)
            )
        end
    },
}
