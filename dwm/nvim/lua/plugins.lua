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

  -- Status Line
  use({
    'NTBBloodbath/galaxyline.nvim',
    branch = 'main',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      -- Alterar para minha configuração
      -- require('cosmic.core.statusline')
      require('galaxyline.themes.eviline')
    end,
  })

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
      require('gitsigns').setup()
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
          TODO = { color = 'info' },
          HACK = { color = 'warning' },
          WARN = { color = 'warning', alt = { 'WARNING', 'XXX' } },
          PERF = { alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
          NOTE = { color = 'hint', alt = { 'INFO' } },
        },
        colors = {
          error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
          warning = { 'DiagnosticWarning', 'WarningMsg', '#FBBF24' },
          info = { 'DiagnosticInformation', '#2563EB' },
          hint = { 'DiagnosticHint', '#10B981' },
          default = { 'Identifier', '#7C3AED' },
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
