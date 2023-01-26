require('common')
G.loaded_netrw=1
G.loaded_netrwPlugin = 1

require('plugins')
require('keymappings')

-- Sources
G.node_host_prog = "~/AppData/Local/Yarn/bin/neovim-node-host"
G.python3_host_prog = "~/scoop/apps/python/current/py.exe"

-- Text format and encoding
O.encoding = 'utf-8'
BO.fileencoding = 'utf-8'

-- Window
O.number = true
O.relativenumber = true

-- Mouse
O.mouse = 'a'

-- Window splits
O.splitbelow = true
O.splitright = true

-- Editing
O.tabstop = 2
O.shiftwidth = 2
O.softtabstop = 2
O.expandtab = true
O.autoindent = true
O.cc = '80'
O.breakindent = true
O.breakindentopt = 'shift:2'
CMD[[autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79 cc=80,73]]
CMD[[autocmd FileType meson setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79 cc=80]]
CMD[[autocmd FileType c setlocal cc=100]]
CMD[[autocmd FileType h setlocal cc=100]]
CMD[[autocmd FileType rust setlocal cc=100]]
CMD[[autocmd BufWritePre * %s/\s\+$//e]]

-- Bracket Pairs
require('pears').setup()
require('indent_blankline').setup{
  show_current_context = true,
  show_current_context_start = false,
  char = '▏',
  use_treesitter = true,
}

-- Code Folding
WO.foldmethod = 'indent'
O.foldlevel = 99

-- Wrap
WO.wrap = false

-- Persist undo after closing buffer
O.undofile = true
O.undodir = '/tmp'

-- Autoinsert on open term
CMD('autocmd TermOpen * startinsert')

-- Vim Grepper
G.grepper = { next_tool = '<leader>g'};

CMD[[
    packadd fzf
    packadd nvim-treesitter
]]

-- Lightline
O.laststatus = 2
O.showmode = false

-- Set minimum window height
O.wmh = 0

-- Theme options
CMD[[colorscheme carbonfox]]

require('lualine').setup {
  options = {
    component_separators = {left = '>', right = '<'},
    section_separators = {left = '', right = ''},
  },
  tabline = {
    lualine_a = {'tabs'},
    lualine_b = {'buffers'},
  },
  sections = {
    lualine_b = {'filename', 'branch'},
    lualine_c = {'diff', 'diagnostics'},
  },
}

-- Custom column colors
CMD[[hi VertSplit ctermfg=234 ctermbg=234 cterm=NONE]]
CMD[[hi LineNr ctermfg=100 ctermbg=NONE cterm=NONE]]

require('nvim-tree').setup{
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
  root_dirs = { ".git" },
  view = {
    mappings = {
      list = {
        { key = {"<CR>", "<2-LeftMouse>"}, action = "edit" },
        { key = "v", action = "vsplit" },
        { key = "s", action = "split" },
        { key = "h", action = "close_node" },
        { key = "o", action = "system_open" },
      },
    },
  },
}

require('symbols-outline').setup()
require('renamer').setup()
require('project_nvim').setup({
  patterns = { ".git" },
})
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers),
  -- or a list of languages
  ensure_installed = {
    "c", "cpp", "lua", "rust", "python", "svelte"
  },

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

-- Emmet shortcuts
G.user_emmet_mode='n'
G.user_emmet_leader_key=','

G.html_indent_script1='inc'
G.html_indent_style1='inc'

-- Custom comments
G.NERDCustomDelimiters = { html = { left = '/* ', right = ' */'}};

-- Compile plugins on change
CMD[[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.nvim_workspace()
lsp.setup()
