local utils = require("utils")

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local widgets = require("dap.ui.widgets")

    require("mason-nvim-dap").setup({
      automatic_setup = true,
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
      icons = utils.dap_icons,
      controls = utils.dap_icons_controls,
    })

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    -- Enabled adapters and configurations
    local adapters = require("plugins.dap.adapters")
    for index, value in pairs(adapters) do
      dap.adapters[index] = value
    end

    local configurations = require("plugins.dap.configurations")
    for index, value in pairs(configurations) do
      dap.configurations[index] = value
    end
  end,
}
