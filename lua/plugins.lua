local install_path = Fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if Fn.empty(Fn.glob(install_path)) > 0 then
  Packer_bootstrap = Fn.system({
	  'git', 'clone', '--depth', '1',
	  'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Fancy start page for vim
  use 'mhinz/vim-startify'

  -- Better quickfix window
  use {'kevinhwang91/nvim-bqf', ft = 'qf'}

  -- Fuzzy finder
  use 'junegunn/fzf'

  -- Text parser, LSP, and syntax checkers and semantic highlights
  use {'nvim-treesitter/nvim-treesitter'}
  use 'mattn/emmet-vim'
  use 'L3MON4D3/LuaSnip'
  use 'nvim-lua/plenary.nvim'

  -- Language server protocols
  use 'VonHeikemen/lsp-zero.nvim'
  use { 'neovim/nvim-lspconfig',
    requires = {
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lua',
      'rafamadriz/friendly-snippets'
    }
  }
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  use { "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end
  }

  -- Autocompletion framework
  use "hrsh7th/nvim-cmp"
  use {
    -- cmp LSP completion
    "hrsh7th/cmp-nvim-lsp",
    -- cmp Snippet completion
    "hrsh7th/cmp-vsnip",
    -- cmp Path completion
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    after = { "hrsh7th/nvim-cmp" },
    requires = { "hrsh7th/nvim-cmp" },
  }

  use { 'tzachar/cmp-tabnine',
    after = "nvim-cmp",
    run='powershell ./install.ps1',
    requires = 'hrsh7th/nvim-cmp'
  }
  -- Snippet engine
  use 'hrsh7th/vim-vsnip'
  -- Adds extra functionality over rust analyzer
  use "simrat39/rust-tools.nvim"

  -- Optional
  use "nvim-lua/popup.nvim"
  use "nvim-telescope/telescope.nvim"

  -- Bracket pair colorizer
  use 'lukas-reineke/indent-blankline.nvim'
  use 'p00f/nvim-ts-rainbow'

  -- Make directory the root
  use 'ahmedkhalf/project.nvim'

  -- Flake 8 python linter
  use 'nvie/vim-flake8'

  -- VS-Code like renaming
  use { 'filipdutescu/renamer.nvim', branch = 'master' }

  -- File Explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
  }

  -- Colorschemes
  use 'jacoborus/tender.vim'
  use 'EdenEast/nightfox.nvim'

  -- Git plugins
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'

  -- Move between panes
  use 'christoomey/vim-tmux-navigator'

  -- Adds ctags
  use 'majutsushi/tagbar'

  -- Perl support
  use 'jacquesg/p5-Neovim-Ext'

  -- Assist with formatting
  use 'preservim/nerdcommenter'
  use 'steelsojka/pears.nvim'

  -- Plugins for tabs and statuslines
  use 'ap/vim-buftabline'
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- Automatically set up your configuration after cloning packer.nvim
  if Packer_bootstrap then
    require('packer').sync()
  end
end)
