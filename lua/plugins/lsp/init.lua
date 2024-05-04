local utils = require("utils")

-- diagnostics
local options = { border = "rounded", source = "always" }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, options)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, options)

vim.diagnostic.config({
  virtual_text = false,
  float = {
    focusable = true,
    border = "rounded",
    source = "always",
    header = "",
    -- prefix = "",
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
          package_installed = utils.mason_signs.Done,
          package_pending = utils.mason_signs.Pending,
          package_uninstalled = utils.mason_signs.Failed,
        },
      },
      max_concurrent_installers = 1,
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local mason_lspconfig = require("mason-lspconfig")

      -- NOTE: make sure to setup neodev BEFORE lspconfig
      require("neodev").setup({})

      local lsp_defaults = lspconfig.util.default_config
      lsp_defaults.capabilities =
        vim.tbl_deep_extend("force", lsp_defaults.capabilities, cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()))

      local on_attach = function(_, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, utils.remap_opt("[g]o to [D]eclaration", true))
        vim.keymap.set("n", "<leader>gd", "<CMD>Telescope lsp_definitions<CR>", utils.remap_opt("[g]o to [d]definitions", true))
        vim.keymap.set("n", "<leader>gr", "<CMD>Telescope lsp_references<CR>", utils.remap_opt("[g]o to [r]eferences", true))
        vim.keymap.set("n", "<leader>gi", "<CMD>Telescope lsp_implementations<CR>", utils.remap_opt("[g]o to [i]mplementations", true))
        vim.keymap.set("n", "<leader>gt", "<CMD>Telescope lsp_type_definitions<CR>", utils.remap_opt("[g]o to [t]ype definitions", true))
        vim.keymap.set("n", "<leader>rp", function()
          vim.lsp.buf.rename()
        end, utils.remap_opt("[r]ename string [p]roject wide", true))
        vim.keymap.set("n", "<leader>ws", function()
          vim.lsp.buf.workspace_symbol()
        end, utils.remap_opt("[w]orkspace [s]ymbol", true))
        vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, utils.remap_opt("open floating information under cursor", true))
        vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, utils.remap_opt("open floating singature under cursor", true))
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, utils.remap_opt("[c]ode [a]ction under cursor", true))

        -- Diagnostics
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, utils.remap_opt("open floating diagnostic message", true))
        vim.keymap.set("n", "[d", function()
          vim.diagnostic.goto_next()
        end, utils.remap_opt("go to next diagnostic", true))
        vim.keymap.set("n", "]d", function()
          vim.diagnostic.goto_prev()
        end, utils.remap_opt("go to next diagnostic", true))

        vim.keymap.set("n", "<leader>mF", function()
          vim.lsp.buf.format()
        end, utils.remap_opt("[m]ode [F]ormat using lsp", true))
      end

      -- ensure servers are installed
      require("mason-tool-installer").setup({ ensure_installed = utils.ensure_installed_mason })
      local servers = require("plugins.lsp.servers")

      -- mason independent
      servers.dartls(lspconfig, on_attach, lsp_defaults)

      mason_lspconfig.setup()
      mason_lspconfig.setup_handlers({
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({
            on_attach = on_attach,
            capabilities = lsp_defaults.capabilities,
          })
        end,

        -- targeted overrides for specific servers.
        ["intelephense"] = function()
          servers.intelephense(lspconfig, on_attach, lsp_defaults)
        end,
        ["eslint"] = function()
          servers.eslint(lspconfig, on_attach, lsp_defaults)
        end,
        ["helm_ls"] = function()
          servers.helm_ls(lspconfig, on_attach, lsp_defaults)
        end,
        ["emmet_ls"] = function()
          servers.emmet_ls(lspconfig, on_attach, lsp_defaults)
        end,
        ["html"] = function()
          servers.html(lspconfig, on_attach, lsp_defaults)
        end,
        ["jsonls"] = function()
          servers.jsonls(lspconfig, on_attach, lsp_defaults)
        end,
        ["tsserver"] = function()
          servers.tsserver(lspconfig, on_attach, lsp_defaults)
        end,
        ["rust_analyzer"] = function()
          servers.rust_analyzer(lspconfig, on_attach, lsp_defaults)
        end,
        ["pyright"] = function()
          servers.pyright(lspconfig, on_attach, lsp_defaults)
        end,
        ["gopls"] = function()
          servers.gopls(lspconfig, on_attach, lsp_defaults)
        end,
        ["lua_ls"] = function()
          servers.lua_ls(lspconfig, on_attach, lsp_defaults)
        end,
      })
    end,
  },
}
