"""packs and themes
call plug#begin('~/.vim/plugged')
"Plug 'ayu-theme/ayu-vim', { 'frozen': 1 }
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lambdalisue/fern.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'puremourning/vimspector'
"Plug 'ianding1/leetcode.vim'
Plug 'wellle/targets.vim'
Plug 'christoomey/vim-run-interactive'
Plug 'gabrielsimoes/cfparser.vim'
Plug 'chrisbra/Colorizer'
call plug#end()
"""

"""generics
set encoding=utf-8
syntax on
set relativenumber
set number
set nohlsearch
set expandtab  
set tabstop=2  
set shiftwidth=2  
set autoindent  
set smartindent
set colorcolumn=100
set clipboard=unnamedplus
set clipboard+=unnamed
set breakindent
set linebreak
set showbreak=›››\     " there's a trailing <Space>, here.
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
"""

"""theme
"set termguicolors     " enable true colors suppor
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
colorscheme nord
"let g:airline_theme='ayu_dark'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight clear SignColumn 
highlight clear ToolbarLine
"highlight Toolbarbutton ctermfg=59 ctermbg=149 guifg=#3D424D guibg=#C2D94C 
"highlight Pmenu guifg=#B3B1AD guibg=#0A0E14
"highlight clear Pmenu 
"highlight PmenuSel guifg=#E6B450 guibg=#0A0E14
"highlight PmenuSbar guifg=#E6B450 guibg=#E6B450
"highlight PmenuThumb guifg=#E6B450 guibg=#0A0E14
"highlight CocErrorSign guifg=#F07178 guibg=#0A0E14
"highlight CocErrorFloat guifg=#F07178 guibg=#0A0E14
"highlight ColorColumn ctermbg=gray
"""

"""fixes
augroup FastEscape
	    autocmd!
	    au InsertEnter * set timeoutlen=0
	    au InsertLeave * set timeoutlen=1000
augroup END
"fix bad indentation after paste, thanks to Marcin Kulik @coderwall.com
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
	  set pastetoggle=<Esc>[201~
	  set paste
	  return ""
endfunction
"""

""""""""""""""""""""""""""plugin configs
"""airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
"""

"""fern
let g:fern#default_hidden=1
augroup my-fern-startup
	  autocmd! *
	  autocmd VimEnter * ++nested Fern . -reveal=% -drawer -stay
augroup END

function! s:init_fern() abort
"Use 'select' instead of 'edit' for default 'open' action
	set norelativenumber
	set signcolumn=no
	set nonumber
	nmap <buffer><expr>
	        \ <Plug>(fern-my-expand-or-enter)
	        \ fern#smart#drawer(
	        \   "\<Plug>(fern-open-or-expand)",
	        \   "\<Plug>(fern-open-or-enter)",
	        \ )
	  nmap <buffer><expr>
	          \ <Plug>(fern-my-collapse-or-leave)
	          \ fern#smart#drawer(
	          \   "\<Plug>(fern-action-collapse)",
	          \   "\<Plug>(fern-action-leave)",
	          \ )
	    nmap <buffer><nowait> l <Plug>(fern-my-expand-or-enter)
	    nmap <buffer><nowait> <enter> <Plug>(fern-my-expand-or-enter)
	    nmap <buffer><nowait> <Right> <Plug>(fern-my-expand-or-enter)
	    nmap <buffer><nowait> h <Plug>(fern-my-collapse-or-leave)
	    nmap <buffer><nowait> <Left> <Plug>(fern-my-collapse-or-leave)
endfunction
augroup fern-custom
	autocmd! *
	autocmd FileType fern call s:init_fern()
augroup END
"""

"""coc
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"""

"""vimspector
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
"""

"""leetcode
"let g:leetcode_browser='firefox'
""
"""""""""""""""""""""""""

"""vim append
nnoremap <silent> a :set opfunc=Append<CR>g@
nnoremap <silent> i :set opfunc=Insert<CR>g@

function! Append(type, ...)
    call feedkeys("`]a", 'n')
endfunction

function! Insert(type, ...)
    call feedkeys("`[i", 'n')
endfunction
""""
