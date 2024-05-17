return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = false,
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          { "branch", color = { fg = "#ffffff", gui = "bold" } },
          "diff",
          "diagnostics",
        },
        lualine_c = {
          { "filename", file_status = false, path = 1, color = { fg = "#c678dd", gui = "bold" } },
          "filesize",
          {
            function()
              local msg = "No Active Lsp"
              local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
              local clients = vim.lsp.get_clients()
              if next(clients) == nil then
                return msg
              end
              for _, client in ipairs(clients) do
                -- find an other way...
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  return client.name
                end
              end
              return msg
            end,
            icon = "LSP:",
            color = { fg = "#ffffff", gui = "bold" },
          },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = {},
      },
    },
  },

  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    lazy = false,
    enabled = true,
    opts = {
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = "bold",
      },
    },
    config = function()
      vim.cmd.colorscheme("nightfox")
    end,
  },
}
