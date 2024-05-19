return {
  "L3MON4D3/LuaSnip",
  -- version = "v2.*",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local ls = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()
    -- taken from https://github.com/echasnovski/nvim/blob/master/src/plugins/luasnip.lua

    ---@diagnostic disable-next-line: duplicate-set-field
    Config.luasnip_go_right = function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    Config.luasnip_go_left = function()
      if ls.jumpable() then
        ls.jump(-1)
      end
    end

    vim.api.nvim_set_keymap("i", "<C-l>", [[<Cmd>lua Config.luasnip_go_right()<CR>]], {})
    vim.api.nvim_set_keymap("s", "<C-l>", [[<Cmd>lua Config.luasnip_go_right()<CR>]], {})

    vim.api.nvim_set_keymap("i", "<C-h>", [[<Cmd>lua Config.luasnip_go_left()<CR>]], {})
    vim.api.nvim_set_keymap("s", "<C-h>", [[<Cmd>lua Config.luasnip_go_left()<CR>]], {})

    -- Notify about presence of snippet. This is my attempt to try to live without
    -- snippet autocompletion. At least for the time being to get used to new
    -- snippets. NOTE: this code is run *very* frequently, but it seems to be fast
    -- enough (~0.1ms during normal typing).
    local luasnip_ns = vim.api.nvim_create_namespace("luasnip")

    ---@diagnostic disable-next-line: duplicate-set-field
    Config.luasnip_notify_clear = function()
      vim.api.nvim_buf_clear_namespace(0, luasnip_ns, 0, -1)
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    Config.luasnip_notify = function()
      if not ls.expandable() then
        return Config.luasnip_notify_clear()
      end
      local line = vim.api.nvim_win_get_cursor(0)[1] - 1
      ---@diagnostic disable-next-line: deprecated
      vim.api.nvim_buf_set_virtual_text(0, luasnip_ns, line, { { "!", "Special" } }, {})
    end

    vim.cmd([[au InsertEnter,CursorMovedI,TextChangedI,TextChangedP * lua pcall(Config.luasnip_notify)]])
    vim.cmd([[au InsertLeave * lua pcall(Config.luasnip_notify_clear)]])
  end,
}
