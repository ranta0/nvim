return {
  delve = {
    type = "server",
    port = "${port}",
    executable = {
      command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
      args = { "dap", "-l", "127.0.0.1:${port}" },
    },
  },

  php = {
    type = "executable",
    command = "node",
    args = { vim.fn.stdpath("data") .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
  },
}
