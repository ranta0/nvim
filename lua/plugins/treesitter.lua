local utils = require("utils")

return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        opts = function()
            return {
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = {"php"},
                    disable = function(lang, bufnr)
                        return lang == "javascript" and vim.api.nvim_buf_line_count(bufnr) > 50000
                    end,
                },
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
                ensure_installed = utils.ensure_installed_hl,
                rainbow = {
                    enable = true,
                    disable = { "html" },
                    extended_mode = false,
                    max_file_lines = nil,
                },
                autotag = {
                    enable = true
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<c-space>',
                        node_incremental = '<c-space>',
                    },
                },
                indent = {
                    enable = true
                }
            }
        end,
        config = function(_,opts)
            pcall(require("nvim-treesitter.install").update{ with_sync = true })

            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            enable = true,
            max_lines = 0,
            min_window_height = 0,
            line_numbers = true,
            multiline_threshold = 20,
            trim_scope = 'outer',
            mode = 'cursor',
            separator = nil,
            zindex = 20,
        }
    }
}
