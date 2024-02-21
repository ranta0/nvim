local utils = require("utils")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "/", "ms/")
vim.keymap.set("n", "?", "ms?")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "gf", "<C-w>gf")
vim.keymap.set("n", "<C-t>", ":tabnew<CR>")
vim.keymap.set("n", "<C-l>", "gt")
vim.keymap.set("n", "<C-h>", "gT")

vim.keymap.set("n", "<C-a>", "ggVG<cr>")

vim.keymap.set("n", "tr", [[:%s///gn<CR>``cgn]],
  utils.remap_opt("replace value after search under cursor, . to continue",true)
)
vim.keymap.set("n", "tR", [[:%s///gn<CR>``cgN]],
  utils.remap_opt("replace value after search under cursor, . to continue backwards",true)
)

vim.keymap.set("i", "<C-o>", "{<Cr>}<Esc>O",
  utils.remap_opt("{} snippet",true)
)

vim.keymap.set("n", "<leader>x", "<CMD>!chmod +x %<CR>",
  utils.remap_opt("make the current file executable",true)
)

vim.keymap.set("v", "T", ":s/\\s\\+$//e<Left><CR>",
  utils.remap_opt("remove trailing characters",true)
)

vim.keymap.set("n", "<leader>tw", ":set wrap!<CR>",
 utils.remap_opt("[t]oggle [w]rap",true)
)

vim.keymap.set("n", "<leader>tn", ":set relativenumber!<CR>",
  utils.remap_opt("[t]oggle relative[n]umber",true)
)

vim.keymap.set("n", "<leader>th", ":set hls!<CR>",
  utils.remap_opt("[t]oggle [h]lsearch",true)
)
