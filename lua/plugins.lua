local install_path = FN.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if FN.empty(FN.glob(install_path)) > 0 then
  Packer_bootstrap = FN.system({
	  'git', 'clone', '--depth', '1',
	  'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Fancy start page for vim
  use 'mhinz/vim-startify'

  -- Fuzzy finder
  use 'junegunn/fzf'

  -- Native LSP config
  use 'VonHeikemen/lsp-zero.nvim'
  use { 'neovim/nvim-lspconfig',
    requires = {
      -- LSP Support
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    }
  }

  use 'nvim-lua/plenary.nvim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'mattn/emmet-vim'

  -- Optional
  use 'nvim-telescope/telescope.nvim'
  use 'simrat39/symbols-outline.nvim'

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
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
  }

  -- Colorschemes
  use 'jacoborus/tender.vim'
  use 'EdenEast/nightfox.nvim'

  -- Git plugins
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'

  -- Perl support
  use 'jacquesg/p5-Neovim-Ext'

  -- Assist with formatting
  use 'preservim/nerdcommenter'
  use 'steelsojka/pears.nvim'

  -- Plugins for tabs and statuslines
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'nvim-tree/nvim-web-devicons', opt = true}
  }

  -- Pane navigator
  use 'christoomey/vim-tmux-navigator'

  -- Automatically set up your configuration after cloning packer.nvim
  if Packer_bootstrap then
    require('packer').sync()
  end
end)
