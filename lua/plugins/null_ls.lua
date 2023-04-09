return {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    opts = function()
        local null_ls = require("null-ls")
        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics
        local code_actions = null_ls.builtins.code_actions

        return {
            debug = false,
            sources = {
                formatting.shfmt,
                formatting.stylua,
                -- formatting.prettier,
                formatting.clang_format,
                formatting.taplo,
                formatting.black,
                diagnostics.trail_space,
                -- diagnostics.phpcs.with({
                --     diagnostics_postprocess = function(diagnostic)
                --         diagnostic.severity = vim.diagnostic.severity["WARN"]
                --     end,
                -- }),
                -- diagnostics.editorconfig_checker, -- to study
                code_actions.gitsigns,
            },
        }
    end,
}
