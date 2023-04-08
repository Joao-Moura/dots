local core = require('decay.core')

local theme = 'dark-decay'
local colors = core.get_colors(theme)

vim.cmd('colorscheme ' .. theme)

return colors
