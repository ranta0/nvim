return {
  "mfussenegger/nvim-lint",
  lazy = true,
  event = { "BufReadPre", "BufNewFile", "SessionLoadPost" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      -- markdown = { "markdownlint" },
      -- php = { "phpstan" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>ml", function()
      lint.try_lint()
    end, Config.remap_opt("[m]ode [l]inting for current file", true))
  end,
}
