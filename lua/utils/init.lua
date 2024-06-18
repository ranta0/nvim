Config.undodir = os.getenv("HOME") .. "/.vim/undodir"
Config.sessiondir = os.getenv("HOME") .. "/.vim/sessionsdir"

Config.diagnostics_signs = {
  Error = "✗ ",
  Warn = "! ",
  Hint = "➜ ",
  Info = "# ",
}

Config.mason_signs = {
  Done = "✓",
  Pending = "➜",
  Failed = "✗",
}

Config.dap_icons = {
  expanded = "▾",
  collapsed = "▸",
  current_frame = "*",
}

Config.dap_icons_controls = {
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

Config.ensure_installed_hl = {
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

Config.bigfile = {
  size_limit = 16 * 1024 * 1024, -- MB
}

Config.remap_opt = function(desc, silent)
  local bufopts = {
    noremap = true,
    silent = silent,
    desc = desc,
  }
  return bufopts
end

Config.grep = function(ignore_case)
  ignore_case = ignore_case or 1
  local cmd = "silent grep! "
  if ignore_case == 1 then
    cmd = cmd .. " --ignore-case "
  end
  local search = vim.fn.input("Grep > ")
  vim.cmd(cmd .. search)
  vim.cmd("copen")
end
