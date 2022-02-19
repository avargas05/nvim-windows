function Toggle_wrap()
  if(Wopt.wrap == true) then
	  print("Wrap OFF")
	  Wopt.wrap = false
	  Opt.virtualedit = 'all'
	  Unmap(0, 'n', '<Up>')
	  Unmap(0, 'n', '<Down>')
	  Unmap(0, 'n', '<Home>')
	  Unmap(0, 'n', '<End>')
	  Unmap(0, 'i', '<Up>')
	  Unmap(0, 'i', '<Down>')
	  Unmap(0, 'i', '<Home>')
	  Unmap(0, 'i', '<End>')
  else
	  print("Wrap ON")
	  Wopt.wrap = true
	  Wopt.linebreak = true
	  Wopt.list = false
	  Opt.virtualedit = ''
	  Buff_map(0, '', '<Up>', 'gk', {noremap = true, silent = true})
	  Buff_map(0, '', '<Down>', 'gj', {noremap = true, silent = true})
	  Buff_map(0, '', '<Home>', 'g<Home>', {noremap = true, silent = true})
	  Buff_map(0, '', '<End>', 'g<End>', {noremap = true, silent = true})
	  Buff_map(0, 'i', '<Up>', '<C-o>gk', {noremap = true, silent = true})
	  Buff_map(0, 'i', '<Down>', '<C-o>gj', {noremap = true, silent = true})
	  Buff_map(0, 'i', '<Home>', '<C-o>g<Home>', {noremap = true, silent = true})
	  Buff_map(0, 'i', '<End>', '<C-o>g<End>', {noremap = true, silent = true})
  end
end

function Open_terminal()
  Cmd(':sp')
  Cmd(':term')
end

-- just use `_G` prefix as a global function for a demo
-- please use module instead in reality
function _G.jump2loc(locs)
    locs = locs or Glob.coc_jump_locations
    Fn.setloclist(0, {}, ' ', {title = 'CocLocationList', items = locs})
    local winid = Fn.getloclist(0, {winid = 0}).winid
    if winid == 0 then
        Cmd('abo lw')
    else
        Api.nvim_set_current_win(winid)
    end
end

function _G.diagnostic()
    Fn.CocActionAsync('diagnosticList', '', function(err, res)
        if err == Vim.NIL then
            local items = {}
            for _, d in ipairs(res) do
                local text = ('[%s%s] %s'):format((d.source == '' and 'coc.nvim' or d.source),
                    (d.code == Vim.NIL and '' or ' ' .. d.code), d.message:match('([^\n]+)\n*'))
                local item = {
                    filename = d.file,
                    lnum = d.lnum,
                    end_lnum = d.end_lnum,
                    col = d.col,
                    end_col = d.end_col,
                   text = text,
                    type = d.severity
                }
                table.insert(items, item)
            end
            Fn.setqflist({}, ' ', {title = 'CocDiagnosticList', items = items})

            Cmd('bo cope')
        end
    end)
end

-- Wrap toggle
Map('', '<Leader>w', ':lua Toggle_wrap()<CR>', {noremap = true, silent = true})

-- Commenter
Map('v', '<S-L>', '<plug>NERDCommenterToggle', {noremap = false, silent = true})
Map('n', '<S-L>', '<plug>NERDCommenterToggle', {noremap = false, silent = true})

-- Move through buffers
Map('', '<leader>[', ':bprev<CR>', {noremap = false, silent = true})
Map('', '<leader>]', ':bnext<CR>', {noremap = false, silent = true})
Map('', '<leader>x', ':bd<CR>', {noremap = false, silent = true})
Map('n', ',d', ':b#<bar>bd#<CR>', {noremap = false, silent = true})

-- Resize window widths
Map('n', '<leader>r', ':vert res 100<CR>', {noremap = false, silent = true})

-- Move lines
Map('n', '<A-J>', ':m .+1<CR>==', {noremap = true, silent = true})
Map('n', '<A-K>', ':m .-2<CR>==', {noremap = true, silent = true})
Map('v', '<A-J>', ":m '>+1<CR>gv=gv", {noremap = true, silent = true})
Map('v', '<A-K>', ":m '<-2<CR>gv=gv", {noremap = true, silent = true})

-- Better vertical movement
Map('n', 'j', 'gj', {noremap = true, silent = true})
Map('n', 'k', 'gk', {noremap = true, silent = true})

-- Open and close terminal with F8
Map('n', '<F8>', ':lua Open_terminal()<CR>', {noremap = true})
Map('t', '<F8>', '<C-\\><C-N>:q!<CR>', {noremap = true})

-- Set commands to switching between windows when using the terminal
Map('t', '<C-J>', '<C-\\><C-N><C-W>j<C-W>', {noremap = false})
Map('t', '<C-K>', '<C-\\><C-N><C-W>k<C-W>', {noremap = false})
Map('t', '<C-H>', '<C-\\><C-N><C-W>h<C-W>', {noremap = false})
Map('t', '<C-L>', '<C-\\><C-N><C-W>l<C-W>', {noremap = false})

-- Use vim buffer to copy text from vim across shells
-- NOTE: Does not copy to system clipboard.
Map('v', '<C-c>', ':w! ~/.vimbuffer<CR>', {})
Map('n', '<C-c>', ':.w! ~/.vimbuffer<CR>', {})
Map('', '<C-p>', ':r ~/.vimbuffer<CR>', {})

--Nvim Tree configuration
Map('', '<C-N>', ':NvimTreeToggle<CR>', {})

--Code folding
Map('n', '<space>', 'za', {noremap = true})

-- Tagbar
Map('', '<leader>t', ':TagbarToggle<CR>', {})

-- Fuzzy search
Map('n', '<C-space>', ':FZF<CR>', {noremap = true})

-- Source vim config file
Map('n', '<leader>sc', ':luafile $MYVIMRC<CR>', {noremap = true})

-- Try `gsiw` under word
Map('n', 'gs', '<Plug>(GrepperOperator)', {noremap = false})
Map('x', 'gs', '<Plug>(GrepperOperator)', {noremap = false})

-- Quickfix Diagnostics
Map('n', '<leader>qd', 'v:lua.diagnostic()', {noremap = true, silent = true})

-- Vim Grepper
Map('n', '<leader>g', ':Grepper<CR>', {noremap=true})
Map('n', '<leader>sf', ':Grepper -buffers -query ', {noremap = true})

-- Renamer
Map('i', '<F2>', '<cmd>lua require("renamer").rename()<CR>', {noremap = true, silent = true })
Map('n', '<leader>rn', '<cmd>lua require("renamer").rename()<CR>', {noremap = true, silent = true })
Map('v', '<leader>rn', '<cmd>lua require("renamer").rename()<CR>', {noremap = true, silent = true })
