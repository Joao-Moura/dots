-- talvez colocar em um arquivo separada
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Inicialização e otimização
  use({
    'wbthomason/packer.nvim',
    'lewis6991/impatient.nvim',
    'nathom/filetype.nvim',
    'nvim-lua/plenary.nvim',
  })

  -- Theme
  use({
    'rebelot/kanagawa.nvim',
    as = 'kanagawa'
  })

  use({
    'decaycs/decay.nvim',
    as = 'decay'
  })

  -- Status Line
  --[[ use({
    'NTBBloodbath/galaxyline.nvim',
    branch = 'main',
    config = function()
      require('core.galaxyline')
    end,
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
  }) ]]

  -- File Explorer
  use({
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('core.nvim_tree')
    end,
    opt = true,
    cmd = {
      'NvimTreeClipboard',
      'NvimTreeClose',
      'NvimTreeFindFile',
      'NvimTreeOpen',
      'NvimTreeRefresh',
      'NvimTreeToggle',
    },
  })

  -- Dashboard de abertura do nvim
  use({
    'glepnir/dashboard-nvim',
    config = function()
      require('core.dashboard')
    end,
  })

  -- Git status nos arquivos
  use({
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    opt = true,
    event = 'BufRead',
    config = function()
      require('core.gitsigns')
    end,
  })

  -- Fuzzy file
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
      }
    },
    -- config = function()
      -- Alterar para a minha configuração
      -- require('cosmic.core.navigation')
    -- end,
    event = 'BufWinEnter',
  })

  -- Comentários
  use({
    'b3nj5m1n/kommentary',
    event = 'BufWinEnter',
  })

  -- Highlight do todo
  use({
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('todo-comments').setup {
	signs = false,
	keywords = {
          FIX = {
            color = 'error',
            alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE', 'fix', 'fixme', 'bug' },
          },
          TODO = { color = 'todo' },
          HACK = { color = 'hack' },
          WARN = { color = 'warning', alt = { 'WARNING', 'XXX' } },
          PERF = { color = 'perf', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
          NOTE = { color = 'info', alt = { 'INFO' } },
        },
        colors = {
          error = { 'DiagnosticError', 'ErrorMsg', '#B66467' },
          warning = { 'DiagnosticWarning', 'WarningMsg', '#D9BC8C' },
          todo = { 'DiagnosticInformation', '#8C977D' },
          info = { 'DiagnosticHint', '#8DA3B9' },
          perf = { 'Identifier', '#A988B0' },
        }
      }
    end,
    event = 'BufWinEnter',
  })

  -- Cores no código
  use({
    'norcalli/nvim-colorizer.lua',
    opt = true,
    cmd = { 'ColorizerToggle' },
    config = function()
      require('colorizer').setup()
    end,
  })
end)
