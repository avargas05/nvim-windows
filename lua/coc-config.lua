-- TextEdit might fail if hidden is not set.
Opt.hidden = true

-- Some servers have issues with backup files, see #649.
Opt.backup = false
Opt.writebackup = true

-- Give more space for displaying messages.
Opt.cmdheight = 2

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
Opt.updatetime = 300

-- Don't pass messages to |ins-completion-menu|.
Opt.shortmess = 'c'

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
--# Recently vim can merge signcolumn and number column into one
if Fn.has("patch-8.1.1564") == 1 then
  Wopt.signcolumn = Opt.number
else
  Wopt.signcolumn = 'yes'
end

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
local function t(str)
    return Api.nvim_replace_termcodes(str, true, true, true)
end

local function check_back_space()
  local col = Fn.col('.') - 1
  return col <= 0 or Fn.getline('.'):sub(col, col):match('%s')
end

function _G.smart_tab()
    return Fn.pumvisible() == 1 and t'<C-n>' or check_back_space() and t'<Tab>' or Fn['coc#refresh']()
end

function _G.shift_tab()
    return Fn.pumvisible() == 1 and t'<C-p>' or t'<C-h>'
end

Map('i', '<Tab>', 'v:lua.smart_tab()', {expr = true, noremap = true, silent = true})
Map('i', '<S-Tab>', 'v:lua.shift_tab()', {expr = true, noremap = true})

-- Make <CR> auto-select the first completion item and notify coc.nvim to
-- format on enter, <CR> could be remapped by other vim plugin
function _G.smart_enter()
  return Fn.pumvisible() == 1 and Fn['coc#_select_confirm']() or t'<C-G>u<CR><C-R>=coc#on_enter()<CR>'
end

Map('i', '<CR>', 'v:lua.smart_enter()', {noremap = true, expr = true, silent = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
Map('n', '[g', '<Plug>(coc-diagnostic-prev)', {silent = true})
Map('n', ']g', '<Plug>(coc-diagnostic-next)', {silent = true})

-- GoTo code navigation.
Map('n', 'gd', '<Plug>(coc-definition)', {silent = true})
Map('n', 'gy', '<Plug>(coc-type-definition)', {silent = true})
Map('n', 'gi', '<Plug>(coc-implementation)', {silent = true})
Map('n', 'gr', '<Plug>(coc-references)', {silent = true})

-- Use K to show documentation in preview window.
function Show_documentation()
  local filetype = Bopt.filetype
  if filetype == "vim" or filetype == "help" then
    Cmd("h " .. Fn.expand("<cword>"))
  elseif Fn["coc#rpc#ready"]() then
    Fn.CocActionAsync("doHover")
  else
    Cmd("!" .. Bopt.keywordprg .. " " .. Fn.expand("<cword>"))
  end
end

Map('n', 'K', ':lua Show_documentation()<CR>', {noremap = true, silent = true})

-- Highlight the symbol and its references when holding the cursor.
Cmd[[autocmd CursorHold * silent call CocActionAsync('highlight')]]

-- Symbol renaming.
Map('n', '<leader>rn', '<Plug>(coc-rename)', {})

-- Formatting selected code.
Map('x', '<leader>f', '<Plug>(coc-format-selected)', {})
Map('n', '<leader>f', '<Plug>(coc-format-selected)', {})

  --# Setup formatexpr specified filetype(s).
  --# Update signature help on jump placeholder.
Cmd[[
  augroup mygroup
    autocmd!
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end
]]

-- https://github.com/neoclide/coc.nvim
-- if you use coc-fzf, you should disable its CocLocationsChange event
-- to make bqf work for <Plug>(coc-references)
--Schedule(function()
  --Cmd('au! CocFzfLocation User CocLocationsChange')
--end)

Glob.coc_enable_locationlist = 0

Cmd[[
    aug Coc
        au!
        au User CocLocationsChange ++nested lua _G.jump2loc()
    aug END
]]

-- Applying codeAction to the selected region.
-- Example: `<leader>aap` for current paragraph
Map('x', '<leader>a', '<Plug>(coc-codeaction-selected)', {})
Map('n', '<leader>a', '<Plug>(coc-codeaction-selected)', {})

-- Remap keys for applying codeAction to the current buffer.
Map('n', '<leader>ac', '<Plug>(coc-codeaction)', {})

-- Apply AutoFix to problem on the current line.
Map('n', '<leader>qf', '<Plug>(coc-fix-current)', {})

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
Map('x', 'if', '<Plug>(coc-funcobj-i)', {})
Map('o', 'if', '<Plug>(coc-funcobj-i)', {})
Map('x', 'af', '<Plug>(coc-funcobj-a)', {})
Map('o', 'af', '<Plug>(coc-funcobj-a)', {})
Map('x', 'ic', '<Plug>(coc-funcobj-i)', {})
Map('o', 'ic', '<Plug>(coc-funcobj-i)', {})
Map('x', 'ac', '<Plug>(coc-funcobj-a)', {})
Map('o', 'ac', '<Plug>(coc-funcobj-a)', {})

-- Remap <C-f> and <C-b> for scroll float windows/popups.
Map('n', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"',
   {expr = true, noremap = true, silent = true, nowait = true})
Map('n', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"',
   {expr = true, noremap = true, silent = true, nowait = true})
Map('i', '<C-f>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"',
   {expr = true, noremap = true, silent = true, nowait = true})
Map('i', '<C-b>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"',
   {expr = true, noremap = true, silent = true, nowait = true})
Map('v', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"',
   {expr = true, noremap = true, silent = true, nowait = true})
Map('v', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"',
   {expr = true, noremap = true, silent = true, nowait = true})

-- Use CTRL-S for selections ranges.
-- Requires 'textDocument/selectionRange' support of language server.
Map('n', '<C-s>', '<Plug>(coc-range-select)', {silent = true})
Map('x', '<C-s>', '<Plug>(coc-range-select)', {silent = true})

-- Add `:Format` command to format current buffer.
Cmd[[command! -nargs=0 Format :call CocAction('format')]]

-- Add `:Fold` command to fold current buffer.
Cmd[[command! -nargs=? Fold :call     CocAction('fold', <f-args>)]]

-- Add `:OR` command for organize imports of the current buffer.
Cmd[[command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')]]

-- Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
Cmd[[set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}]]

-- Mappings for CoCList
-- Show all diagnostics.
Map('n', '<space>a', ':<C-u>CocList diagnostics<CR>', {noremap = true, silent = true, nowait = true})

-- Manage extensions.
Map('n', '<space>e', ':<C-u>CocList extensions<CR>', {noremap = true, silent = true, nowait = true})

-- Show commands.
Map('n', '<space>c', ':<C-u>CocList commands<CR>', {noremap = true, silent = true, nowait = true})

-- Find symbol of current document.
Map('n', '<space>o', ':<C-u>CocList outline<CR>', {noremap = true, silent = true, nowait = true})

-- Search workspace symbols.
Map('n', '<space>s', ':<C-u>CocList -I symbols<CR>', {noremap = true, silent = true, nowait = true})

-- Do default action for next item.
Map('n', '<space>j', ':<C-u>CocNext<CR>', {noremap = true, silent = true, nowait = true})

-- Do default action for previous item.
Map('n', '<space>k', ':<C-u>CocPrev<CR>', {noremap = true, silent = true, nowait = true})

-- Resume latest coc list.
Map('n', '<space>p', ':<C-u>CocListResume<CR>', {noremap = true, silent = true, nowait = true})
