-- diagnostics
local options = { border = "rounded", source = "always" }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, options)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, options)

vim.diagnostic.config({
  virtual_text = true,
  float = {
    focusable = true,
    source = true,
    header = "",
  },
})

for type, icon in pairs(Config.diagnostics_signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.keymap.set("n", "<leader>td", function()
  vim.diagnostic.setqflist()
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd("copen")
  end
end, Config.remap_opt("[t]oggle [d]iagnostic", true))

return {
  {
    "folke/neodev.nvim",
    opts = {},
  },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      pip = {
        upgrade_pip = true,
      },
      ui = {
        border = "single",
        icons = {
          package_installed = Config.mason_signs.Done,
          package_pending = Config.mason_signs.Pending,
          package_uninstalled = Config.mason_signs.Failed,
        },
      },
      max_concurrent_installers = 1,
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      -- NOTE: make sure to setup neodev BEFORE lspconfig
      require("neodev").setup({})

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function()
          -- vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          vim.opt_local.omnifunc = "v:lua.MiniCompletion.completefunc_lsp"

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
          vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

          vim.keymap.set("n", "<leader>rp", vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
          vim.keymap.set("n", "<leader>mf", vim.lsp.buf.format, { buffer = 0 })
          vim.keymap.set("n", "<leader>ws", function()
            vim.lsp.buf.workspace_symbol()
          end, { buffer = 0 })

          if vim.lsp.inlay_hint then
            vim.keymap.set("n", "<leader>ti", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
            end, { buffer = 0 })
          end

          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
        end,
      })

      local lsp_defaults = lspconfig.util.default_config
      local servers = require("plugins.lsp.servers")
      -- mason independent
      -- servers.dartls(lspconfig, lsp_defaults)

      -- this exists in mason, but it might be easier this way
      -- servers.psalm(lspconfig, lsp_defaults)

      mason_lspconfig.setup()
      mason_lspconfig.setup_handlers({
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({
            capabilities = lsp_defaults.capabilities,
          })
        end,

        -- targeted overrides for specific servers.
        ["intelephense"] = function()
          servers.intelephense(lspconfig, lsp_defaults)
        end,
        ["eslint"] = function()
          servers.eslint(lspconfig, lsp_defaults)
        end,
        ["helm_ls"] = function()
          servers.helm_ls(lspconfig, lsp_defaults)
        end,
        ["emmet_ls"] = function()
          servers.emmet_ls(lspconfig, lsp_defaults)
        end,
        ["html"] = function()
          servers.html(lspconfig, lsp_defaults)
        end,
        ["jsonls"] = function()
          servers.jsonls(lspconfig, lsp_defaults)
        end,
        ["tsserver"] = function()
          servers.tsserver(lspconfig, lsp_defaults)
        end,
        ["rust_analyzer"] = function()
          servers.rust_analyzer(lspconfig, lsp_defaults)
        end,
        ["pyright"] = function()
          servers.pyright(lspconfig, lsp_defaults)
        end,
        ["gopls"] = function()
          servers.gopls(lspconfig, lsp_defaults)
        end,
        ["lua_ls"] = function()
          servers.lua_ls(lspconfig, lsp_defaults)
        end,
      })
    end,
  },
}
