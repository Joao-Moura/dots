local themes = {
  'kanagawa',
}

local theme_in_use = 'kanagawa'
local colors = {}
local mod = 'theme.integrated.'

for _, theme in pairs(themes) do
  if theme == theme_in_use then
    colors = require(mod .. theme)
  end
end

return colors
