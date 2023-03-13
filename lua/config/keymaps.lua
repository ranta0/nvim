local utils = require("utils")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<TAB>", "<CMD>bnext<CR>")
vim.keymap.set("n", "<S-TAB>", "<CMD>bprevious<CR>")

vim.keymap.set("n", "<C-a>", "ggVG<cr>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  utils.remap_opt("raw rename all occurrences under cursor",true)
)

-- vim.keymap.set("n", "<leader>ow", ":set wrap<CR>")
-- vim.keymap.set("n", "<leader>Ow", ":set nowrap<CR>")
vim.keymap.set("n", "<leader>tw", function()
  utils.toggle("wrap")
end, utils.remap_opt("[t]oggle [w]rap",true))
