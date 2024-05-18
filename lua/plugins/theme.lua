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
        lualine_a = {},
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
              local clients = vim.lsp.get_active_clients({ bufnr = vim.fn.bufnr() })
              if vim.fn.has("nvim-0.10") then
                clients = vim.lsp.get_clients({ bufnr = vim.fn.bufnr() })
              end
              if next(clients) == nil then
                return "No Active Lsp"
              end
              local names = {}
              for _, lsp in ipairs(clients) do
                table.insert(names, lsp.name)
              end
              return table.concat(names, ", ")
            end,
            icon = "LSP:",
            color = { fg = "#ffffff", gui = "bold" },
          },
        },
        lualine_x = { "filetype", "encoding", "fileformat" },
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
