vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf" },
  command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = { "bash-fc.*" },
  command = [[set syntax=sh filetype=sh]],
})
