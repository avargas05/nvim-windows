require('common')
require('plugins')
require('keymappings')
require('coc-config')

-- Text format and encoding
Opt.encoding = 'utf-8'
Bopt.fileencoding = 'utf-8'
Opt.fileformat = 'unix'

-- Window
Opt.number = true
Opt.relativenumber = true

-- Mouse
Opt.mouse = 'a'

-- Window splits
Opt.splitbelow = true
Opt.splitright = true

-- Editing
Opt.tabstop = 2
Opt.shiftwidth = 2
Opt.softtabstop = 2
Opt.expandtab = true
Opt.autoindent = true
Opt.cc = '80'
Opt.breakindent = true
Opt.breakindentopt = 'shift:2'
Cmd[[autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79 cc=80,73]]
Cmd[[autocmd FileType meson setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79 cc=80]]
Cmd[[autocmd FileType c setlocal cc=100]]
Cmd[[autocmd FileType h setlocal cc=100]]
Cmd[[autocmd FileType rust setlocal cc=100]]
Cmd[[autocmd BufWritePre * %s/\s\+$//e]]

-- Bracket Pairs
require('pears').setup()
require('indent_blankline').setup{
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter = true,
}

-- Code Folding
Wopt.foldmethod = 'indent'
Opt.foldlevel = 99

-- Wrap
Wopt.wrap = false

-- Persist undo after closing buffer
Opt.undofile = true
Opt.undodir = '/tmp'

-- Autoinsert on open term
Cmd('autocmd TermOpen * startinsert')

-- Vim Grepper
Cmd[[let g:grepper = { 'next_tool': '<leader>g'}]]

Cmd[[
    packadd nvim-bqf
    packadd fzf
    packadd nvim-treesitter
    packadd vim-grepper
    packadd coc.nvim
]]

-- https://github.com/mhinz/vim-grepper
Glob.grepper = {tools = {'rg', 'grep'}, searchreg = 1}

Cmd(([[
    aug Grepper
        au!
        au User Grepper ++nested %s
    aug END
]]):format([[call setqflist([], 'r', {'context': {'bqf': {'pattern_hl': '\%#' . getreg('/')}}})]]))

-- Lightline
Opt.laststatus = 2
Opt.showmode = false

-- Set minimum window height
Opt.wmh = 0

-- Theme options
Cmd[[colorscheme tender]]
require('lualine').setup {
  options = {
    component_separators = {left = '>', right = '<'},
    section_separators = {left = '', right = ''},
  }
}

-- Custom column colors
Cmd[[hi VertSplit ctermfg=234 ctermbg=234 cterm=NONE]]
Cmd[[hi LineNr ctermfg=100 ctermbg=NONE cterm=NONE]]

-- Set python providers
Glob.python3_host_prog = '/usr/bin/python'
Glob.python_host_prog = '/usr/bin/python2'

-- Change nvim-tree root directory
Glob.nvim_tree_respect_buf_cwd = 1
require('nvim-tree').setup({
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
})

require('renamer').setup()
require('project_nvim').setup()

require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers),
  -- or a list of languages
  ensure_installed = "maintained",

  update_cwd = true,
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    colors = {'#f43753', '#c9d05c', '#ffc24b', '#b3deef', '#d3b987', '#73cef4',
      '#1d1d1d',
    }
  }
}

-- Compile plugins on change
Cmd[[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]
