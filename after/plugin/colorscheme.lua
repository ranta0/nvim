local present, catppuccin = pcall(require, "catppuccin")

if not present then
    return
end

catppuccin.setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    show_end_of_buffer = false,
    transparent_background = true,
    term_colors = true,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.45,
    },
    styles = {
        comments = { "bold" },
    },
    color_overrides = {
        mocha = {
            base = "#1A1A2F",
        },
    },
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        dashboard = true,
        telescope = true,
        which_key = true,
        treesitter = true,
        hop = true,
        mason = true,
        ts_rainbow = true,
        noice = true,
        notify = true,
        lsp_saga = true,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
        },
        -- (https://github.com/catppuccin/nvim#integrations)
    },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
