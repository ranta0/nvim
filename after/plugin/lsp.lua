local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lspinstaller = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local utils = require("utils")

-- NOTE: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({})

local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities = vim.tbl_deep_extend(
  "force",
  lsp_defaults.capabilities,
  cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration,
    utils.remap_opt("[g]o to [D]eclaration", true)
  )
  vim.keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<cr>",
    utils.remap_opt("[g]o to [d]definitions",true)
  )
  vim.keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<cr>",
    utils.remap_opt("[g]o to [r]eferences",true)
  )
  vim.keymap.set("n", "<leader>gi", "<cmd>Telescope lsp_implementations<cr>",
    utils.remap_opt("[g]o to [i]mplementations",true)
  )
  vim.keymap.set("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<cr>",
    utils.remap_opt("[g]o to [t]ype definitions",true)
  )
  vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover,
    utils.remap_opt("open floating information under cursor",true)
  )
  vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help,
    utils.remap_opt("open floating singature under cursor",true)
  )
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder,
    utils.remap_opt("[w]orkspace [a]dd folder",true)
  )
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder,
    utils.remap_opt("[w]orkspace [r]emove folder",true)
  )
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, utils.remap_opt("[w]orkspace [l]ist folders",true))
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
    utils.remap_opt("rename all references under cursor",true)
  )
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
    utils.remap_opt("[c]ode [a]ction under cursor",true)
  )

  -- Diagnostics
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float,
    utils.remap_opt("open floating diagnostic message",true)
  )
end

local mason_default_settings = {
  ensure_installed = utils.ensure_installed_lsp,
  automatic_installation = false,
  ui = {
    border = "single",
    icons = {
      package_installed = utils.mason_signs.Done,
      package_pending = utils.mason_signs.Pending,
      package_uninstalled = utils.mason_signs.Failed,
    },
  },
  max_concurrent_installers = 1,
}

lspinstaller.setup(mason_default_settings)

mason_lspconfig.setup()
mason_lspconfig.setup_handlers({
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup({
      on_attach = on_attach,
      capabilities = lsp_defaults.capabilities,
    })
  end,
  -- Next, you can provide targeted overrides for specific servers.
  ["cssls"] = function()
    lsp_defaults.capabilities.textDocument.completion.completionItem.snippetSupport = true
    lspconfig.cssls.setup({
      on_attach = on_attach,
      capabilities = lsp_defaults.capabilities,
    })
  end,
  ["emmet_ls"] = function()
    lspconfig.emmet_ls.setup({
      on_attach = on_attach,
      capabilities = lsp_defaults.capabilities,
      filetypes = {
        "html",
        "css",
        "sass",
        "scss",
        "less",
        "vue",
        "javascriptreact",
        "typescriptreact",
        "jsx",
        "tsx",
        "gohtml",
        "tmpl.html",
      },
    })
  end,
  ["html"] = function()
    lsp_defaults.capabilities.textDocument.completion.completionItem.snippetSupport = true
    lspconfig.html.setup({
      on_attach = on_attach,
      capabilities = lsp_defaults.capabilities,
      filetypes = {
        "html",
        "handlebars",
        "htmldjango",
        "blade",
        "gohtml",
        "tmpl.html",
      },
    })
  end,
  ["jsonls"] = function()
    lsp_defaults.capabilities.textDocument.completion.completionItem.snippetSupport = true
    lspconfig.jsonls.setup({
      on_attach = on_attach,
      capabilities = lsp_defaults.capabilities,
    })
  end,
  ["tsserver"] = function()
    lspconfig.tsserver.setup({
      on_attach = on_attach,
      capabilities = lsp_defaults.capabilities,
      filetypes = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "jsx",
        "tsx",
      },
    })
  end,
  ["rust_analyzer"] = function()
    lspconfig.rust_analyzer.setup({
      on_attach = on_attach,
      capabilities = lsp_defaults.capabilities,
      settings = {
        ["rust-analyzer"] = {
          assist = {
            importGranularity = "module",
            importPrefix = "self",
          },
          cargo = {
            loadOutDirsFromCheck = true,
          },
          procMacro = {
            enable = true,
          },
          checkOnSave = {
            command = "clippy",
          },
        },
      },
    })
    -- require("rust-tools").setup {}
  end,
  ["pyright"] = function()
    lspconfig.pyright.setup({
      on_attach = on_attach,
      capabilities = lsp_defaults.capabilities,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true,
          },
        },
      },
    })
  end,
  ["gopls"] = function()
    lspconfig.gopls.setup({
      on_attach = on_attach,
      capabilities = lsp_defaults.capabilities,
      cmd = { "gopls", "serve" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    })
  end,
})
