-- 'onedark-revisited' color scheme
-- https://github.com/LalitMaganti/base16-onedark-scheme

local palette = {
  base00 = "#282c34",
  base01 = "#353b45",
  base02 = "#3e4451",
  -- base03 = "#545862", -- hard to see
  -- base04 = "#565c64",
  -- base05 = "#abb2bf",
  -- base06 = "#b6bdca",
  base03 = "#6e6a86",
  base04 = "#908caa",
  base05 = "#e0def4",
  base06 = "#e0def4",

  base07 = "#c8ccd4",
  base08 = "#e06c75",
  base09 = "#d19a66",
  base0A = "#e5c07b",
  base0B = "#98c379",
  base0C = "#56b6c2",
  base0D = "#61afef",
  base0E = "#c678dd",
  base0F = "#be5046",
}

if palette then
  require("mini.base16").setup({ palette = palette })
  vim.g.colors_name = "onedark-revisited"
end
