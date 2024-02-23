local utils = require("utils")

local options = { border = "rounded", source = "always" }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, options)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, options)

vim.diagnostic.config({
  virtual_text = false,
  float = {
    focusable = false,
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

for type, icon in pairs(utils.diagnostics_signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

return {
  "folke/trouble.nvim",
  config = function()
    local opts = {
      icons = false,
      use_diagnostic_signs = true,
      fold_open = "v",
      fold_closed = ">",
      indent_lines = false,
    }
    require("trouble").setup(opts)

    vim.keymap.set("n", "<leader>sd", "<CMD>Trouble workspace_diagnostics<CR>", utils.remap_opt("[s]earch [d]iagnostics", true))
  end,
}
