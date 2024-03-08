local M = {}

M.diagnostics_signs = {
  Error = "✗ ",
  Warn = "! ",
  Hint = "➜ ",
  Info = "# ",
}

M.mason_signs = {
  Done = "✓",
  Pending = "➜",
  Failed = "✗",
}

M.dap_icons = {
  expanded = "▾",
  collapsed = "▸",
  current_frame = "*",
}

M.dap_icons_controls = {
  icons = {
    pause = "⏸",
    play = "▶",
    step_into = "⏎",
    step_over = "⏭",
    step_out = "⏮",
    step_back = "b",
    run_last = "▶▶",
    terminate = "⏹",
    disconnect = "⏏",
  },
}

M.ensure_installed_hl = {
  "vimdoc",
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

M.ensure_installed_mason = {
  "css-lsp",
  "lua-language-server",
  "prettier",
  "prettierd",
  "stylua",
  "intelephense",
  "tsserver",
  "shfmt",
  -- "delve",
  -- "php-debug-adapter",
}

function M.remap_opt(desc, silent)
  local bufopts = {
    noremap = true,
    silent = silent,
    desc = desc,
  }
  return bufopts
end

return M
