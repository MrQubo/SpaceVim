" Only do this when not done yet for this buffer.
if exists("b:did_ftplugin")
  finish
endif

" hi clear Conceal
" hi Conceal ctermfg=gray
" setlocal conceallevel=2
" setlocal concealcursor=
" let g:indentLine_setConceal = 0
" let g:indentLine_setColors = 0
setlocal conceallevel=0

setlocal nocindent
setlocal indentexpr=
