vim.g.floaterm_width = 0.95
vim.g.floaterm_height = 0.95

local utils = require("utils")
vim.keymap.set('n', '<leader>g', ':FloatermNew lazygit<CR>',
  utils.remap_opt("open lazygit",true)
)
