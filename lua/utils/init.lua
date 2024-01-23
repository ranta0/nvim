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

function M.remap_opt(desc, silent)
    local bufopts = {
        noremap = true,
        silent = silent,
        desc = desc
    }
    return bufopts
end

return M
