vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.smartindent = true
vim.o.inccommand = "split"

vim.o.wrap = false
vim.o.list = true
vim.o.listchars = table.concat({
  "tab:> ",
  "trail:-",
  "extends:>",
  "precedes:<",
  "nbsp:+",
}, ",")

vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true

vim.o.incsearch = true

vim.o.termguicolors = true

vim.o.updatetime = 50
vim.o.lazyredraw = true

vim.o.colorcolumn = "80"
vim.o.signcolumn = "yes:4"

vim.o.scrolloff = 8
vim.o.grepprg = "grep -rnH --exclude-dir={.git,node_modules,vendor} --ignore-case"
vim.o.grepformat = "%f:%l:%m"
vim.g.netrw_liststyle = 3
