vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.smartindent = true

vim.o.wrap = false
vim.o.list = true
vim.opt.listchars:append("eol:↴")

vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true

vim.o.incsearch = true

vim.o.termguicolors = true

vim.o.updatetime = 50
vim.o.lazyredraw = true

vim.o.colorcolumn = "80"
vim.o.signcolumn = "yes:2"

-- session
vim.o.sessionoptions = "buffers,tabpages,options"

vim.g.session_dir = os.getenv("HOME") .. "/.vim/sessionsdir"
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  pattern = { "*" },
  callback = function()
    if next(vim.fn.argv()) ~= nil then
      return
    end

    local function file_exists(path)
      local file = io.open(path, "r")
      if file then
        file:close()
        return true
      end

      return false
    end

    local dir = vim.fn.getcwd():gsub("/", "_")
    local session_file = vim.g.session_dir .. "/" .. dir
    if file_exists(session_file) then
      vim.cmd("so " .. session_file)
    end
  end,
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
  pattern = { "*" },
  callback = function()
    os.execute("mkdir -p " .. vim.g.session_dir)

    local dir = vim.fn.getcwd():gsub("/", "_")
    vim.cmd("mksession! " .. vim.g.session_dir .. "/" .. dir)
  end,
})
