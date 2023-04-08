local themes = {
  'kanagawa',
  'decay',
  'paradise'
}

local theme_in_use = 'paradise'
local colors = {}
local mod = 'theme.integrated.'

for _, theme in pairs(themes) do
  if theme == theme_in_use then
    colors = require(mod .. theme)
  end
end

return colors
