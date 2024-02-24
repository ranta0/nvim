local utils = require("utils")

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local widgets = require("dap.ui.widgets")

    require("mason-nvim-dap").setup({
      automatic_setup = true,
      ensure_installed = {
        -- "delve",
        -- "php-debug-adapter",
      },
    })

    -- Basic debugging keymaps
    vim.keymap.set("n", "<F5>", function()
      require("dap").continue()
    end, utils.remap_opt("[F5] debug start/continue", true))
    vim.keymap.set("n", "<leader>dc", function()
      require("dap").continue()
    end, utils.remap_opt("[d]ebug [c]ontinue/start", true))
    vim.keymap.set("n", "<F2>", function()
      require("dap").step_over()
    end, utils.remap_opt("[F2] debug step over", true))
    vim.keymap.set("n", "<leader>do", function()
      dap.step_over()
    end, utils.remap_opt("[d]ebug step [o]ver", true))
    vim.keymap.set("n", "<F1>", function()
      dap.step_into()
    end, utils.remap_opt("[F1] debug step into", true))
    vim.keymap.set("n", "<leader>di", function()
      dap.step_into()
    end, utils.remap_opt("[d]ebug step [i]nto", true))
    vim.keymap.set("n", "<F12>", function()
      dap.step_out()
    end, utils.remap_opt("[F3] debug step out", true))
    vim.keymap.set("n", "<leader>dO", function()
      dap.step_out()
    end, utils.remap_opt("[d]ebug step [O]ut", true))
    vim.keymap.set("n", "<Leader>db", function()
      dap.toggle_breakpoint()
    end, utils.remap_opt("[d]ebug toggle [b]reakpoint", true))
    vim.keymap.set("n", "<Leader>dB", function()
      dap.set_breakpoint()
    end, utils.remap_opt("[d]ebug set [B]reakpoint", true))
    vim.keymap.set("n", "<Leader>lp", function()
      dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end, utils.remap_opt("debug [l]og [p]point message", true))
    -- vim.keymap.set("n", "<Leader>dr", function()
    --   dap.repl.open()
    -- end)
    -- vim.keymap.set("n", "<Leader>dl", function()
    --   dap.run_last()
    -- end)
    -- vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
    --   widgets.hover()
    -- end)
    -- vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
    --   widgets.preview()
    -- end)
    vim.keymap.set("n", "<Leader>df", function()
      widgets.centered_float(widgets.frames)
    end, utils.remap_opt("[d]ebug float [f]rames", true))
    vim.keymap.set("n", "<Leader>ds", function()
      widgets.centered_float(widgets.scopes)
    end, utils.remap_opt("[d]ebug float [s]copes", true))

    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      controls = {
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
      },
    })

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    -- Go
    -- Configuration
    dap.adapters.delve = {
      type = "server",
      port = "${port}",
      executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:${port}" },
      },
    }

    -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
    dap.configurations.go = {
      {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}",
      },
      {
        type = "delve",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}",
      },
      -- works with go.mod packages and sub packages
      {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}",
      },
    }

    -- Note in case you must listen to a docker image add this to the service in the docker-compose
    --  extra_hosts:
    --  - "host.docker.internal:host-gateway"
    dap.adapters.php = {
      type = "executable",
      command = "node",
      args = { os.getenv("HOME") .. "/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
    }

    dap.configurations.php = {
      {
        name = "Run current script",
        type = "php",
        request = "launch",
        port = 9004,
        cwd = "${fileDirname}",
        program = "${file}",
        runtimeExecutable = "php",
      },
      {
        name = "Listen for Xdebug local",
        type = "php",
        request = "launch",
        port = 9004,
      },
      {
        name = "Listen for Xdebug docker",
        type = "php",
        request = "launch",
        port = 9004,
        -- this is where your file is in the container
        pathMappings = {
          ["/var/www/app"] = "${workspaceFolder}",
        },
      },
    }
  end,
}
