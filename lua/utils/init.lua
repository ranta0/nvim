local M = {}

M.diagnostics_signs = {
    Error = "✗ ",
    Warn = "! ",
    Hint = "➜ ",
    Info = "# "
}

M.mason_signs = {
    Done = "✓",
    Pending = "➜",
    Failed = "✗"
}

M.ensure_installed_hl = {
    "markdown",
    "tsx",
    "typescript",
    "javascript",
    "toml",
    "json",
    "yaml",
    "rust",
    "css",
    "lua",
    "php",
    "go",
    "bash",
}

M.ensure_installed_lsp = {
    "black",
    "css-lsp",
    "dockerfile-language-server",
    "emmet-ls",
    -- "eslint-lsp",
    "eslint_d",
    "gopls",
    "graphql-language-service-cli",
    "html-lsp",
    "json-lsp",
    "lua-language-server",
    -- "prettier",
    "prettierd",
    "pyright",
    "rust-analyzer",
    "stylua",
    "typescript-language-server",
    "vue-language-server",
    "yaml-language-server",
}

-- 
function M.toggle(option, values)
    if values then
        if vim.opt_local[option]:get() == values[1] then
            vim.opt_local[option] = values[2]
        else
            vim.opt_local[option] = values[1]
        end
        return require("utils").info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
    end
    vim.opt_local[option] = not vim.opt_local[option]:get()
end

function M.remap_opt(desc, silent)
    local bufopts = {
        noremap = true,
        silent = silent,
        desc = desc
    }
    return bufopts
end

return M
