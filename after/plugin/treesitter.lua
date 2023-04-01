local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

local utils = require("utils")
treesitter.setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {"php"},
    disable = function(lang, bufnr)
      return lang == "javascript" and vim.api.nvim_buf_line_count(bufnr) > 50000
    end,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  ensure_installed = utils.ensure_installed_hl,
  rainbow = {
    enable = true,
    disable = { "html" },
    extended_mode = false,
    max_file_lines = nil,
  },
  autotag = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
    },
  },
  indent = {
    enable = true
  },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

local present_context, treesitter_context = pcall(require, "treesitter-context")

if not present_context then
  return
end

treesitter_context.setup{
  enable = true,
  max_lines = 0,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = 'outer',
  mode = 'cursor',
  separator = nil,
  zindex = 20,
}
