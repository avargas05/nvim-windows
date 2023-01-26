function Toggle_wrap()
  if(WO.wrap == true) then
	  print("Wrap OFF")
	  WO.wrap = false
	  O.virtualedit = 'all'
	  UNMAP(0, 'n', '<Up>')
	  UNMAP(0, 'n', '<Down>')
	  UNMAP(0, 'n', '<Home>')
	  UNMAP(0, 'n', '<End>')
	  UNMAP(0, 'i', '<Up>')
	  UNMAP(0, 'i', '<Down>')
	  UNMAP(0, 'i', '<Home>')
	  UNMAP(0, 'i', '<End>')
  else
	  print("Wrap ON")
	  WO.wrap = true
	  WO.linebreak = true
	  WO.list = false
	  O.virtualedit = ''
	  BUFF_MAP(0, '', '<Up>', 'gk', {noremap = true, silent = true})
	  BUFF_MAP(0, '', '<Down>', 'gj', {noremap = true, silent = true})
	  BUFF_MAP(0, '', '<Home>', 'g<Home>', {noremap = true, silent = true})
	  BUFF_MAP(0, '', '<End>', 'g<End>', {noremap = true, silent = true})
	  BUFF_MAP(0, 'i', '<Up>', '<C-o>gk', {noremap = true, silent = true})
	  BUFF_MAP(0, 'i', '<Down>', '<C-o>gj', {noremap = true, silent = true})
	  BUFF_MAP(0, 'i', '<Home>', '<C-o>g<Home>', {noremap = true, silent = true})
	  BUFF_MAP(0, 'i', '<End>', '<C-o>g<End>', {noremap = true, silent = true})
  end
end

function Open_terminal()
  CMD(':sp')
  CMD(':term')
end

-- Wrap toggle
MAP('', '<Leader>w', ':lua Toggle_wrap()<CR>', {noremap = true, silent = true})

-- Commenter
MAP('v', '<S-L>', '<plug>NERDCommenterToggle', {noremap = false, silent = true})
MAP('n', '<S-L>', '<plug>NERDCommenterToggle', {noremap = false, silent = true})

-- Move through buffers
MAP('', '<leader>[', ':bprev<CR>', {noremap = false, silent = true})
MAP('', '<leader>]', ':bnext<CR>', {noremap = false, silent = true})
MAP('', '<leader>x', ':bd<CR>', {noremap = false, silent = true})
MAP('n', ',d', ':b#<bar>bd#<CR>', {noremap = false, silent = true})

-- Resize window widths
MAP('n', '<leader>r', ':vert res 100<CR>', {noremap = false, silent = true})

-- Move lines
MAP('n', '<A-J>', ':m .+1<CR>==', {noremap = true, silent = true})
MAP('n', '<A-K>', ':m .-2<CR>==', {noremap = true, silent = true})
MAP('v', '<A-J>', ":m '>+1<CR>gv=gv", {noremap = true, silent = true})
MAP('v', '<A-K>', ":m '<-2<CR>gv=gv", {noremap = true, silent = true})

-- Open and close terminal with F8
MAP('n', '<F8>', ':lua Open_terminal()<CR>', {noremap = true})
MAP('t', '<F8>', '<C-\\><C-N>:q!<CR>', {noremap = true})

-- Set commands to switching between windows when using the terminal
MAP('t', '<C-J>', '<C-\\><C-N><C-W>j<C-W>', {noremap = false})
MAP('t', '<C-K>', '<C-\\><C-N><C-W>k<C-W>', {noremap = false})
MAP('t', '<C-H>', '<C-\\><C-N><C-W>h<C-W>', {noremap = false})
MAP('t', '<C-L>', '<C-\\><C-N><C-W>l<C-W>', {noremap = false})

-- Use vim buffer to copy text from vim across shells
-- NOTE: Does not copy to system clipboard.
MAP('v', '<C-c>', ':w! ~/.vimbuffer<CR>', {})
MAP('n', '<C-c>', ':.w! ~/.vimbuffer<CR>', {})
MAP('', '<C-p>', ':r ~/.vimbuffer<CR>', {})

--Nvim Tree configuration
MAP('', '<C-N>', ':NvimTreeToggle<CR>', {})

--Code folding
MAP('n', '<space>', 'za', {noremap = true})

-- Tagbar
MAP('', '<leader>t', ':SymbolsOutline<CR>', {})

-- Fuzzy search
MAP('n', '<C-space>', ':FZF<CR>', {noremap = true})

-- Source vim config file
MAP('n', '<leader>sc', ':luafile $MYVIMRC<CR>', {noremap = true})

-- Try `gsiw` under word
MAP('n', 'gs', '<Plug>(GrepperOperator)', {noremap = false})
MAP('x', 'gs', '<Plug>(GrepperOperator)', {noremap = false})

-- Quickfix Diagnostics
MAP('n', '<leader>qd', 'v:lua.diagnostic()', {noremap = true, silent = true})

-- Vim Grepper
MAP('n', '<leader>g', ':Grepper<CR>', {noremap=true})
MAP('n', '<leader>sf', ':Grepper -buffers -query ', {noremap = true})

-- Renamer
MAP('i', '<F2>', '<cmd>lua require("renamer").rename()<CR>', {noremap = true, silent = true })
MAP('n', '<leader>rn', '<cmd>lua require("renamer").rename()<CR>', {noremap = true, silent = true })
MAP('v', '<leader>rn', '<cmd>lua require("renamer").rename()<CR>', {noremap = true, silent = true })
