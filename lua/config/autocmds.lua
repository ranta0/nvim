vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf" },
  command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>:lclose<CR>]],
})

-- do not continue comments on new line
vim.cmd([[autocmd BufEnter * set formatoptions-=cro]])

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = { "bash-fc.*" },
  command = [[set syntax=sh filetype=sh]],
})

vim.api.nvim_create_autocmd({ "BufReadPre" }, {
  callback = function(event)
    if event.file then
      local status, size = pcall(function()
        return vim.loop.fs_stat(event.file).size
      end)

      -- If file is too big, block it and use something else
      if status and size > Config.bigfile.size_limit then
        print(string.format("File is bigger than %sMB, it is set to [Readonly]", Config.bigfile.size_limit))
        local settings = {
          swapfile = false,
          bufhidden = "unload",
          buftype = "nowrite",
          undolevels = -1,
          syntax = "OFF",
        }

        for option, value in pairs(settings) do
          vim.bo[option] = value
        end
      end
    end
  end,
})
