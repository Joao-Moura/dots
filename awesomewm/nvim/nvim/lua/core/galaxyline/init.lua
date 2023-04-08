--[[ local galaxyline = require('galaxyline')
local section = galaxyline.section
local colors = require('theme.colors')
local condition = require('galaxyline.condition')
local fileinfo = require('galaxyline.providers.fileinfo')

-- Funções auxiliares
local get_mode = function()
  local mode_colors = {
    [110] = { 'NORMAL', colors.normal, colors.bg_highlight },
    [105] = { 'INSERT', colors.insert, colors.bg_highlight },
    [99]  = { 'COMMAND', colors.command, colors.bg_highlight },
    [116] = { 'TERMINAL', colors.normal, colors.bg_highlight },
    [118] = { 'VISUAL', colors.visual, colors.bg_highlight },
    [22]  = { 'V-BLOCK', colors.visual, colors.bg_highlight },
    [86]  = { 'V-LINE', colors.visual, colors.bg_highlight },
    [82]  = { 'REPLACE', colors.replace, colors.bg_highlight },
    [115] = { 'SELECT', colors.replace, colors.bg_highlight },
    [83]  = { 'S-LINE', colors.replace, colors.bg_highlight },
  }

  local mode_data = mode_colors[vim.fn.mode():byte()]
  if mode_data ~= nil then
    return mode_data
  end
end

local set_highlight = function(hi, colors)
  local hi_str = ''

  for k, v in pairs(colors) do
    hi_str = hi_str .. k .. '=' .. v .. ' '
  end

  vim.cmd(('hi %s %s'):format(hi, hi_str))
end

local function split(str, sep)
  local res = {}
  for w in str:gmatch('([^' .. sep .. ']*)') do
    if w ~= '' then
      table.insert(res, w)
    end
  end
  return res
end

local check_git_and_buffer = function()
  return condition.check_git_workspace() and condition.buffer_not_empty()
end

-- Providers custons
local FilePathShortProvider = function()
  local fp = vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.:h')
  local tbl = split(fp, '/')
  local len = #tbl

  if len > 2 and tbl[1] ~= '~' then
    return '  ./' .. table.concat(tbl, '/', len - 1) .. '/'
  else
    return '  ' .. fp .. '/'
  end
end

local LineColumnProvider = function()
  local line_column = fileinfo.line_column()
  line_column = line_column:gsub('%s+', '')
  return '  ' .. line_column
end

local PercentProvider = function()
  local line_column = fileinfo.current_line_percent()
  line_column = line_column:gsub('%s+', '')
  return line_column .. ' ☰ '
end

galaxyline.short_line_list = {
  'NvimTree',
}

-- Configuração da barra de status
-- Lado esquerdo
section.left[1] = {
  ViMode = {
    provider = function()
        local m = get_mode()
        if m == nil then
          return
        end

        local label, mode_color, mode_nested = unpack(m)
        set_highlight('GalaxyViMode', {
          guibg = mode_color,
          guifg = mode_nested,
        })
        set_highlight('GalaxyViModeInv', {
          guibg = mode_nested,
          guifg = mode_color,
        })
        set_highlight('GalaxyViModeNested', {
          guibg = mode_nested,
          guifg = 'StatusLine',
        })
        set_highlight('GalaxyViModeNestedInv', {
          guibg = 'StatusLine',
          guifg = mode_nested,
        })
        set_highlight('GalaxyPercentBracket', {
          guibg = 'StatusLine',
          guifg = mode_color,
        })
        set_highlight('GalaxyGitLCBracket', {
          guibg = mode_nested,
          guifg = mode_color,
        })

        if condition.buffer_not_empty() then
          set_highlight('GalaxyViModeBracket', {
            guibg = mode_nested,
            guifg = mode_color,
          })
        else
          if condition.check_git_workspace() then
            set_highlight('GalaxyGitLCBracket', {
              guibg = 'StatusLine',
              guifg = mode_color,
            })
          end
          set_highlight('GalaxyViModeBracket', {
            guibg = 'StatusLine',
            guifg = mode_color,
          })
        end
        return '  ' .. label .. ' '
    end,
  },
}

section.left[2] = {
  GitBranch = {
    provider = function()
      local vcs = require('galaxyline.providers.vcs')
      local branch_name = vcs.get_git_branch()
      if not branch_name then
        return ' no git '
      end
      if string.len(branch_name) > 28 then
        return string.sub(branch_name, 1, 25) .. '...'
      end
      return '  ' .. branch_name
    end,
    condition = check_git_and_buffer,
    highlight = 'GalaxyViModeInv',
  },
}

section.left[3] = {
  FilePath = {
    provider = FilePathShortProvider,
    condition = check_buffer_and_width,
    highlight = 'GalaxyViModeInv',
  },
}

section.left[4] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = 'GalaxyViModeInv',
  },
}

-- Lado direito
section.right[1] = {
  FileIcon = {
    provider = function()
      local icon = fileinfo.get_file_icon
      if condition.check_git_workspace() then
        return ' ' .. icon
      end
      return '  ' .. icon
    end,
    condition = condition.buffer_not_empty,
    highlight = 'GalaxyViModeInv',
  }
}

section.right[2] = {
  LineColumn = {
    provider = LineColumnProvider,
    highlight = 'GalaxyViMode',
  },
}

section.right[3] = {
  PerCent = {
    provider = PercentProvider,
    highlight = 'GalaxyViMode',
    separator = ' | ',
    separator_highlight = 'GalaxyViMode',
  },
}

-- Lado esquerdo (Mini)
section.short_line_left[1] = {
  FilePath = {
    provider = FilePathShortProvider,
    condition = check_buffer_and_width,
    highlight = 'GalaxyViModeInv',
  },
}

section.short_line_left[2] = {
  FileNameShort = {
    provider = 'FileName',
    condition = function()
      return condition.buffer_not_empty() and vim.bo.filetype ~= 'NvimTree'
    end,
    highlight = 'GalaxyViModeInv',
  },
} ]]
