local utils = require("utils")

return {
    'stevearc/oil.nvim',
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function ()
        local opts = {
            default_file_explorer = false,
        }
        require("oil").setup(opts)

        vim.keymap.set("n", "<leader>-", require("oil").open,
            utils.remap_opt("open parent dir",true)
        )
    end
}
