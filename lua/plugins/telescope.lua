local utils = require("utils")

return {
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = function()
            return {
                defaults = {
                    mappings = {
                        i = {
                            ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
                        }
                    },
                    preview = {
                        hide_on_startup = true -- hide previewer when picker starts
                    }
                }
            }
        end,
        config = function(_,opts)
            local telescope = require("telescope")

            telescope.setup(opts)
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>?", builtin.oldfiles,
                utils.remap_opt("find recently opened files",true)
            )
            vim.keymap.set("n", "<leader><space>", builtin.buffers,
                utils.remap_opt("find existing buffers",true)
            )
            vim.keymap.set("n", "<leader>sf", builtin.find_files,
                utils.remap_opt("[s]earch [f]iles",true)
            )
            vim.keymap.set("n", "<leader>sh", "<CMD>Telescope find_files hidden=true<CR>",
                utils.remap_opt("[s]earch files [h]idden",true)
            )
            vim.keymap.set("n", "<leader>sg", builtin.live_grep,
                utils.remap_opt("[s]earch by [g]rep",true)
            )
            vim.keymap.set("n", "<leader>sd", builtin.diagnostics,
                utils.remap_opt("[s]earch [d]iagnostics",true)
            )

            -- override default spell_suggest
            vim.keymap.set("n", "z=", "<CMD>silent Telescope spell_suggest<CR>",
                utils.remap_opt("spell suggestion",true)
            )
        end
    },
}
