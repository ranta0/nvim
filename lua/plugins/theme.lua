return {
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
