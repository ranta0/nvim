local utils = require("utils")

-- nice to have
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", "$", "$h")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "gQ", "<nop>")

-- copy/paste
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- tabs
vim.keymap.set("n", "gf", "<C-w>gf")
vim.keymap.set("n", "<C-t>", ":tabnew<CR>")
vim.keymap.set("n", "<C-l>", "gt")
vim.keymap.set("n", "<C-h>", "gT")

-- qf
vim.keymap.set("n", "<C-k>", ":cn<CR>zz")
vim.keymap.set("n", "<C-j>", ":cp<CR>zz")
vim.keymap.set("n", "<leader><C-k>", ":lnext<CR>zz")
vim.keymap.set("n", "<leader><C-j>", ":lprevious<CR>zz")

-- command
vim.keymap.set("c", "<C-p>", "<Up>", { silent = false })
vim.keymap.set("c", "<C-n>", "<Down>", { silent = false })

-- tools
vim.keymap.set("n", "tr", [[:%s///gn<CR>``cgn]], utils.remap_opt("replace value after search under cursor, . to continue", true))
vim.keymap.set("n", "tR", [[:%s///gn<CR>``cgN]], utils.remap_opt("replace value after search under cursor, . to continue backwards", true))
vim.keymap.set("v", "T", ":s/\\s\\+$//e<Left><CR>", utils.remap_opt("remove trailing characters", true))

-- toggles
vim.keymap.set("n", "<leader>tw", ":set wrap!<CR>", utils.remap_opt("[t]oggle [w]rap", true))
vim.keymap.set("n", "<leader>tn", ":set relativenumber!<CR>", utils.remap_opt("[t]oggle relative[n]umber", true))
vim.keymap.set("n", "<leader>th", ":set hls!<CR>", utils.remap_opt("[t]oggle [h]lsearch", true))
vim.keymap.set("n", "<leader>tp", ":set paste!<CR>", utils.remap_opt("[t]oggle [p]aste", true))
