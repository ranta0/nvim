local present, lualine = pcall(require, "lualine")

if not present then
    return
end

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local config = {
    options = {
        icons_enabled = false,
        theme = "catppuccin",
        component_separators = "|",
        section_separators = "",
    },
    sections = {
        lualine_c = {},
    }
}

local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

ins_left({
    "filename",
    cond = conditions.buffer_not_empty,
    color = { fg = "#c678dd", gui = "bold" },
})

ins_left({
    -- filesize component
    "filesize",
    cond = conditions.buffer_not_empty,
})


ins_left({
    -- Lsp server name .
    function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = "LSP:",
    color = { fg = "#ffffff", gui = "bold" },
})

ins_left({
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = "E ", warn = "W ", info = "I " },
    diagnostics_color = {
        color_error = { fg = "#ec5f67" },
        color_warn = { fg = "#ECBE7B" },
        color_info = { fg = "#008080" },
    },
})

lualine.setup(config)
