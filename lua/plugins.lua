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
  use {'mhinz/vim-grepper'}

  -- Fuzzy finder
  use 'junegunn/fzf'

  -- Text parser, LSP, and syntax checkers and semantic highlights
  use {'neoclide/coc.nvim', branch = 'release' }
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'rafcamlet/coc-nvim-lua'
  use 'mattn/emmet-vim'
  use 'pangloss/vim-javascript'
  use 'davisdude/vim-love-docs'
  --use 'neovim/nvim-lspconfig'
  --use 'hrsh7th/nvim-cmp'
  --use 'hrsh7th/cmp-nvim-lsp'
  --use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  --use 'williamboman/nvim-lsp-installer'
  --use 'simrat39/rust-tools.nvim'
  use 'nvim-lua/plenary.nvim'

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
