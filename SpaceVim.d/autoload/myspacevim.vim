"
" BEFORE
"

function! myspacevim#before() abort

  sadsdadsa

" Set default clipboard to system's selection clipboard
set clipboard=unnamed

" search path
set path=$PWD/**

" gui font
set guifont=DroidSansMono\ Nerd\ Font\ Mono\ 11

" line ctx
set scrolloff=8

" wildignore
set wildignore+=*.o,*.pyc

" wildmode
set wildmode=list:longest,longest,full

" default indentation
set smarttab
set noexpandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Enable mouse everywhere
set mouse=ar

" Enable sounds
set noerrorbells
set novisualbell

" fileformats (used for line endings)
set fileformat=unix
set fileformats=unix,dos,mac

" Linebreak on 500 characters
set linebreak
set textwidth=500
set nowrap

" Those features where designed for C-like programs. Doesn't work well in some cases.
setglobal noautoindent
setglobal nocindent
setglobal nosmartindent

" neomake
let g:neomake_place_signs = 1
let g:neomake_open_list = 0

" python linting
let g:neomake_python_enabled_makers = get(g:, 'neomake_python_enabled_makers', ['flake8'])
let g:neomake_python_flake8_args = get(g:, 'neomake_python_flake8_args', ['--extend-ignore=W191,E117'])
let g:neomake_python_flake8_exe = get(g:, 'neomake_python_flake8_exe', 'flake8')

" file manager
" autocmd BufEnter * if bufname("") !~ "^[A-Za-z0-9]*://" | lcd %:p:h | endif
let g:vimfiler_ignore_filters=['matcher_ignore_pattern']
let g:airline_powerline_fonts = 1
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_tree_indentation = 3

" c-support
let g:C_UseTool_cmake    = 'yes'
" let g:C_UseTool_doxygen  = 'yes'
" call mmtemplates#config#Add('C', '<PATH_TO_PLUG>/c-support/templates/doxygen.templates', 'Doxygen', 'ntd')

" vim-startify: {{{
let g:startify_lists = [
      \ { 'type': 'sessions'  },
      \ { 'type': 'commands'  },
      \ { 'type': 'bookmarks' },
      \ { 'type': 'dir'       },
      \ { 'type': 'files'     },
  \ ]
let g:startify_session_persistence = 1
let g:startify_session_autoload = 0
let g:startify_custom_header = 'GenerateStartifyCustomHeader()'

" omnisharp
let g:OmniSharp_server_path = '$OMNISHARP_PATH/omnisharp/OmniSharp.exe'

" tags
let g:gutentags_file_list_command = 'rg --files'
" let g:gutentags_trace = 1

" autosave views
augroup autoload_view
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END

" Decrease the time to wait for k after j in 'jk' in insert mode
autocmd InsertEnter * set timeoutlen=200
autocmd InsertLeave * set timeoutlen=500

" Dir things. Two slashes at the and are important (see `:h 'backupdir'`).
set backupdir=~/.cache/SpaceVim/backup//
set directory=~/.cache/SpaceVim/swap//
set undodir=~/.cache/SpaceVim/undo//
set viewdir=~/.cache/SpaceVim/view//

" Backup files in backupdir.
set backup
set writebackup

" Save original version of file in the same directory as the file (latest version of file is kept in backupdir)
" set patchmode=~

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" repeat macro on each line of selection
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" move lines
" https://vi.stackexchange.com/a/2363
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-Down> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
nnoremap <M-Up> :m .-2<CR>==
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-Down> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv
vnoremap <M-Up> :m '<-2<CR>gv=gv

" vimux
" Run command and show results in tmux's pane
nnoremap <Leader>vp :VimuxPromptCommand<CR>
" Rerun last command
nnoremap <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane (switch to it and start tmux's copy mode)
nnoremap <Leader>vi :VimuxInspectRunner<CR>
" Zoom (maximize) tmux's pane
nnoremap <Leader>vz :VimuxZoomRunner<CR>

augroup remove_delimitMate_mappings
  autocmd BufWinEnter * call <SID>remove_delimitMate_mappings()
augroup END

" vim-easy-align
call SpaceVim#mapping#def('xmap', 'ga', '<Plug>(EasyAlign)', 'vim-easy-align', '')
let g:easy_align_delimiters = {
\ ';': {
\     'pattern': ';',
\     'ignore_groups': [] ,
\ },
\}

" Inspect highlighting mapping
" nnoremap <F9> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
" \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
" \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Indent guides for tabs.
set list lcs=tab:\┊\ |


let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`


" Coqtail colors.
if hlexists('CoqtailChecked')
  hi CoqtailChecked ctermbg=19 guibg=#266826
endif

" Fix for https://github.com/neoclide/coc.nvim/issues/1685#issuecomment-640321914
let g:coc_node_path = exepath('node')


" conceal
set conceallevel=2
set concealcursor=
let g:indentLine_setConceal = 0
let g:indentLine_setColors = 0


set shortmess=filnx

let g:user_emmet_leader_key=','


" TODO: Doesn't work in vimfiler, disable those in it's window.
" noremap <ScrollWheelUp> 16<C-y>
" noremap <ScrollWheelDown> 16<C-e>

endfunction


"
" AFTER
"

function! myspacevim#after() abort

  sadsdadsa

" file manager
let g:vimfiler_ignore_pattern = get(g:, 'vimfiler_ignore_pattern', []) + ['\~$']

" which wrap
set whichwrap=

" shada
if has('nvim')
  set shada-=h
  set shada+=r/tmp
endif

" Stop highlighting when <esc> is pressed.
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" Disable project rooter.
let g:spacevim_project_rooter_patterns = []

" fix tmux <C-j> binding (vim-latex owerwrites it)
unmap <C-j>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>

" Open file under cursor. Create the file if it doesn't exist.
noremap gf :e <cfile><cr>


endfunction


"
" MISC
"

function! s:remove_delimitMate_mappings()
  silent! iunmap <buffer> <BS>
  silent! iunmap <buffer> <C-H>
  silent! iunmap <buffer> <S-BS>
  silent! iunmap <buffer> <C-G>g
  silent! iunmap <buffer> <C-H>
  silent! iunmap <buffer> "
  silent! iunmap <buffer> '
  silent! iunmap <buffer> (
  silent! iunmap <buffer> )
  silent! iunmap <buffer> [
  silent! iunmap <buffer> ]
  silent! iunmap <buffer> `
  silent! iunmap <buffer> {
  silent! iunmap <buffer> }
endfunction

function! VisualSelection(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

function! GenerateStartifyCustomHeader()
  let headers = myspacevim#startify_custom_headers#get()
  let end = len(headers) - 1
  let rand = str2nr(system("shuf -n 1 -i 0-" . end))
  return headers[rand] + startify#fortune#cowsay()
endfunction
