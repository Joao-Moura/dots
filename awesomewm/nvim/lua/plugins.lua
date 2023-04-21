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
  --[[ use({
    'glepnir/dashboard-nvim',
    config = function()
      require('core.dashboard')
    end,
  }) ]]

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
        signs = true,
        --[[ keywords = {
          FIX = {
            icon = 'F',
            color = 'error',
            alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE', 'fix', 'fixme', 'bug' }
          },
          TODO = { icon = 'T', color = 'todo' },
          HACK = { icon = 'H', color = 'hack' },
          WARN = { icon = 'W', color = 'warning', alt = { 'WARNING', 'XXX' } },
          PERF = { icon = 'P', color = 'perf', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
          NOTE = { icon = 'N', color = 'info', alt = { 'INFO' } },
        }, ]]
        colors = {
          error = { '#B66467', },
          warning = { '#D9BC8C', },
          todo = { '#8C977D', },
          info = { '#8DA3B9', },
          perf = { '#A988B0', },
        }
      }
    end,
    -- event = 'BufWinEnter',
  })

  -- Cores no código
  use({
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "lua" },
        auto_install = true,
      })
    end,
  })

  -- Tabs compreensíveis
  use 'nvim-tree/nvim-web-devicons'
  use({
    'romgrk/barbar.nvim',
    requires = 'nvim-web-devicons',
    config = function()
      require('core.barbar')
    end
  })

  -- JSON para configuraçaõ dos servidores LSP
  use({'tamago324/nlsp-settings.nvim'})

  -- LSP Client
  use({
    'neovim/nvim-lspconfig',
    requires = { 'tamago324/nlsp-settings.nvim', 'williamboman/mason-lspconfig.nvim' },
  })

  -- Mason (gerênciar clientes LSP)
  use({'williamboman/mason.nvim'})

  -- Conexão lspconfig e mason
  use({
    'williamboman/mason-lspconfig.nvim',
    requires = { 'williamboman/mason.nvim' }
  })

  -- NULL-ls
  use({'jose-elias-alvarez/null-ls.nvim'})

  -- Nvim autocomplete
  use({
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp' }
  })

  use({'hrsh7th/cmp-nvim-lsp'})

  -- Snippets para autocomplete
  use({'L3MON4D3/LuaSnip'})
  use({'saadparwaiz1/cmp_luasnip'})
end)
