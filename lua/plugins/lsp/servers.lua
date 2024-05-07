local util = require("lspconfig.util")

return {
  eslint = function(lspconfig, on_attach, lsp_defaults)
    -- Note: If working with a repository where eslint is specified in the package.json
    -- but the node_modules are not installed, install eslint globally: npm i -g eslint
    lspconfig.eslint.setup({
      on_attach = on_attach,
      capabilities = lsp_defaults.capabilities,
      root_dir = util.root_pattern(".eslintrc.js", "node_modules", ".git"),
      filetypes = {
        "vue",
        "javascript",
        "typescript",
        "jsx",
        "tsx",
        "vue",
      },
    })
  end,

  intelephense = function(lspconfig, on_attach, lsp_defaults)
    lspconfig.intelephense.setup({
      on_attach = on_attach,
      capabilities = lsp_defaults.capabilities,
      settings = {
        intelephense = {
          enviroment = { version = "8.3.0" },
        },
      },
    })
  end,

  psalm = function(lspconfig, on_attach, lsp_defaults)
    lspconfig.psalm.setup({
      on_attach = on_attach,
      capabilities = lsp_defaults.capabilities,
      cmd = { "psalm", "--language-server" },
      filetypes = { "php" },
      root_dir = util.root_pattern("psalm.xml", "psalm.xml.dist"),
    })
  end,

  emmet_ls = function(lspconfig, on_attach, lsp_defaults)
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

  html = function(lspconfig, on_attach, lsp_defaults)
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

  jsonls = function(lspconfig, on_attach, lsp_defaults)
    lsp_defaults.capabilities.textDocument.completion.completionItem.snippetSupport = true
    lspconfig.jsonls.setup({
      on_attach = on_attach,
      capabilities = lsp_defaults.capabilities,
    })
  end,

  tsserver = function(lspconfig, on_attach, lsp_defaults)
    local mason_registry = require("mason-registry")
    local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
      .. "/node_modules/@vue/language-server"

    lspconfig.tsserver.setup({
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = vue_language_server_path,
            languages = { "vue" },
          },
        },
      },
      on_attach = on_attach,
      capabilities = lsp_defaults.capabilities,
      filetypes = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "jsx",
        "tsx",
        "vue",
      },
    })
  end,

  rust_analyzer = function(lspconfig, on_attach, lsp_defaults)
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

  pyright = function(lspconfig, on_attach, lsp_defaults)
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

  gopls = function(lspconfig, on_attach, lsp_defaults)
    lspconfig.gopls.setup({
      on_attach = on_attach,
      capabilities = lsp_defaults.capabilities,
      cmd = { "gopls", "serve" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = util.root_pattern("go.work", "go.mod", ".git"),
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

  helm_ls = function(lspconfig, on_attach, lsp_defaults)
    lspconfig.helm_ls.setup({
      on_attach = on_attach,
      capabilities = lsp_defaults.capabilities,
      filetypes = { "helm_ls", "serve" },
      root_dir = function(fname)
        return util.root_pattern("Chart.yaml")(fname)
      end,
    })
  end,

  lua_ls = function(lspconfig, on_attach, lsp_defaults)
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = lsp_defaults.capabilities,
      settings = {
        Lua = {
          -- runtime = { version = "Lua 5.1" },
          diagnostics = {
            globals = { "vim", "it", "describe", "before_each", "after_each" },
          },
        },
      },
    })
  end,

  -- not mason related
  dartls = function(lspconfig, on_attach, lsp_defaults)
    lspconfig.dartls.setup({
      on_attach = on_attach,
      capabilities = lsp_defaults.capabilities,
      cmd = { "dart", "language-server", "--protocol=lsp" },
      filetypes = { "dart" },
      root_dir = util.root_pattern("pubspec.yaml"),
      init_options = {
        onlyAnalyzeProjectsWithOpenFiles = true,
        suggestFromUnimportedLibraries = true,
        closingLabels = true,
        outline = true,
        flutterOutline = true,
      },
      settings = {
        dart = {
          completeFunctionCalls = true,
          showTodos = true,
        },
      },
    })
  end,
}
