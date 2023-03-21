local present, telescope = pcall(require, "telescope")

if not present then
    return
end

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-p>"] = require("telescope.actions.layout").toggle_preview
            }
        },
        preview = {
            hide_on_startup = true -- hide previewer when picker starts
        }
    }
})

local utils = require("utils")
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>gs", builtin.git_status,
    utils.remap_opt("[g]it [s]tatus",true)
)
vim.keymap.set("n", "<C-p>", builtin.git_files,
    utils.remap_opt("git files",true)
)
vim.keymap.set("n", "<leader>gc", builtin.git_commits,
    utils.remap_opt("[g]it [c]ommits",true)
)

vim.keymap.set("n", "<leader>?", builtin.oldfiles,
    utils.remap_opt("find recently opened files",true)
)
vim.keymap.set("n", "<leader><space>", builtin.buffers,
    utils.remap_opt("find existing buffers",true)
)
vim.keymap.set("n", "<leader>sf", builtin.find_files,
    utils.remap_opt("[s]earch [f]iles",true)
)
vim.keymap.set("n", "<leader>sh", builtin.help_tags,
    utils.remap_opt("[s]earch [h]elp",true)
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

vim.keymap.set("v", "ga", ":EasyAlign<CR>",
    utils.remap_opt("align columns",false)
)
