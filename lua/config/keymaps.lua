vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
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
vim.keymap.set("n", "<C-t>", ":tabnew<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "gt")
vim.keymap.set("n", "<C-h>", "gT")

-- qf
vim.keymap.set("n", "<C-k>", ":cn<CR>zz")
vim.keymap.set("n", "<C-j>", ":cp<CR>zz")

-- command
vim.keymap.set("c", "<C-p>", "<Up>", { silent = false })
vim.keymap.set("c", "<C-n>", "<Down>", { silent = false })

-- project files
vim.keymap.set("n", "<leader>-", ":Ex<CR>")

-- wildmenu
vim.keymap.set("i", "<TAB>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true, silent = false })
vim.keymap.set("i", "<S-TAB>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true, silent = false })

-- tools
vim.keymap.set("n", "tr", [[*Ncgn]])
vim.keymap.set("n", "<leader>cd", ":lcd%:p:h<CR>:pwd<CR>", { silent = true })

vim.keymap.set("v", "T", ":s/\\s\\+$//e<Left><CR>", Config.remap_opt("remove trailing characters", true))
vim.keymap.set("n", "<leader>sg", Config.grep, Config.remap_opt("[s]earch [g]rep", false))
vim.keymap.set("n", "<leader>sG", function()
  Config.grep(0)
end, Config.remap_opt("[s]earch [G]rep case sensitive", false))

-- toggles
vim.keymap.set("n", "<leader>/", ":let @/ ='' <CR>", Config.remap_opt("[t]oggle [h]lsearch", false))
vim.keymap.set("n", [[,w]], ":set wrap!<CR>", Config.remap_opt("[t]oggle [w]rap", false))
vim.keymap.set("n", [[,n]], ":set relativenumber!<CR>", Config.remap_opt("[t]oggle relative[n]umber", false))
vim.keymap.set("n", [[,h]], ":set hls!<CR>", Config.remap_opt("[t]oggle [h]lsearch", false))
vim.keymap.set("n", [[,p]], ":set paste!<CR>", Config.remap_opt("[t]oggle [p]aste", false))
