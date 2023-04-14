local utils = require("utils")

local options = {border= "rounded", source = "always"}
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  options
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  options
)

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
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            local lsp_lines = require("lsp_lines")
            lsp_lines.setup()
            -- hidden diagnostics on start
            lsp_lines.toggle()
            vim.keymap.set("n", "<leader>tl", lsp_lines.toggle,
                utils.remap_opt("[t]oggle diagnostic [l]ines",true)
            )
        end,
    },
}
