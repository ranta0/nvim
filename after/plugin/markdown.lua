local utils = require("utils")

vim.g.vimwiki_list = {{path = '$HOME/notes'}}
vim.g.vimwiki_ext = '.md'
vim.g.vimwiki_syntax = 'markdown'

vim.keymap.set("n", "<leader>mt", "<CMD>MarkdownPreviewToggle<CR>",
  utils.remap_opt("live markdown of current file",true)
)

vim.keymap.set("n", "<leader>md", ":VimwikiTable",
  utils.remap_opt("make a md table",true)
)
