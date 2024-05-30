-- do not continue comments on new line
vim.cmd([[autocmd BufEnter * set formatoptions-=cro]])

-- qf related
vim.cmd([[autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>:lclose<CR>]])
vim.cmd([[autocmd WinEnter * if &l:buftype ==# 'quickfix' && winnr('$') == 1 && has('timers')
            \ | call timer_start(0, {-> execute('quit') }) | endif]])

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
