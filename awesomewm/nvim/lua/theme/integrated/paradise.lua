local config = require('decay.config')

local colors = {
    -- background = "#FFFFFF",
    background = "#151515",
    contrast = '#131313',
    statusline_bg = '#171717',
    lighter = '#191919',
    foreground = "#E8E3E3",
    cursorline = '#191919',
    comments = '#333333',
    cursor = "#151515",
    black = "#1d1d1d",
    red = "#B66467",
    green = "#8C977D",
    yellow = "#D9BC8C",
    blue = "#8DA3B9",
    magenta = "#A988B0",
    cyan = "#8AA6A2",
    white = "#E8E3E3",
    brightblack = "#424242",
    brightred = "#B66467",
    brightgreen = "#8C977D",
    brightyellow = "#D9BC8C",
    brightblue = "#8DA3B9",
    brightmagenta = "#A988B0",
    brightcyan = "#8AA6A2",
    brightwhite = "#E8E3E3",
    accent = "#707b61",
}

local opts = {
    style = "normal",
    palette_overrides = {},
    cmp = {
            block_kind = false,
    },
    italics = {
            code = true,
            comments = false,
    },
}

local jombas_hack = config.highlights_base(colors, opts)
local extras = {
    Pmenu = { fg = colors.foreground, bg = colors.contrast },
    PmenuSel = { fg = colors.contrast, bg = colors.blue },
    CmpDocumentationBorder = { fg = colors.foreground },
    CmpItemAbbr = { fg = colors.foreground },
    CmpItemAbbrDeprecated = { fg = colors.yellow },
    CmpItemAbbrMatch = { fg = colors.blue },
    CmpItemAbbrMatchFuzzy = { fg = colors.blue },
    CmpItemKind = { fg = colors.blue },
    CmpItemMenu = { fg = colors.green },
}

for key, value in pairs(extras) do
    jombas_hack[key] = value
end

for group, properties in pairs(jombas_hack) do
    vim.api.nvim_set_hl(0, group, properties)
end

return colors
