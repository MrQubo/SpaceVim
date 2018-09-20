function! region#foldexpr() abort
  let line = s:getline(v:lnum)
  if region#is_region_start(line)
    return 'a1'
  elseif region#is_region_end(line)
    return 's1'
  else
    return '='
  endif
endfunction


function! region#foldtext() abort
  return s:foldtext()
endfunction


function! region#buffer_init(parse_line) abort
  let b:region__lasttick = -2
  let b:region__parse_line = a:parse_line
  setlocal foldmethod=expr
  setlocal foldexpr=region#foldexpr()
  setlocal foldtext=region#foldtext()
  silent! execute(':normal zv')
endfunction


function! s:getline(lnum) abort
  if b:region__lasttick != b:changedtick
    let b:region__parse_cache = {}
    let b_region__lasttick = b:changedtick
  elseif has_key(b:region__parse_cache, a:lnum)
    return b:region__parse_cache[a:lnum]
  endif

  let result = b:region__parse_line(getline(a:lnum))
  let b:region__parse_cache[a:lnum] = result
  return result
endfunction


function! s:foldtext() abort
  let result = matchlist(getline(v:foldstart), '\v///=\s*region[[:blank:]:]\s*(.{-})\s*$')

  if len(result) < 2
    return custom_foldtext#foldtext('')
  else
    return custom_foldtext#foldtext('region: ' . result[1])
  endif
endfunction

function! region#is_region_start(line) abort
  return a:line =~? '\v///=\s*region([[:blank:]:]|$)'
endfunction

function! region#is_region_end(line) abort
  return a:line =~? '\v///=\s*endregion(\s|$)'
endfunction


function! region#rsl_dq_we(line) abort
  return substitute(a:line, '\v""|".{-}[^\]"', '', 'gn')
endfunction

function! region#rsl_sq_we(line) abort
  return substitute(a:line, "\\v''|'.{-}[^\\]'", '', 'gn')
endfunction

function! region#rsl_dq_woe(line) abort
  return substitute(a:line, '\v""|".{-}"', '', 'gn')
endfunction

function! region#rsl_sq_woe(line) abort
  return substitute(a:line, "\\v''|'.{-}'", '', 'gn')
endfunction

function! region#rsl_sq_we_dq_we(line) abort
  return region#rsl_sq_we(region#rsl_dq_we(a:line))
endfunction

function! region#rsl_sq_we_dq_woe(line) abort
  return region#rsl_sq_we(region#rsl_dq_woe(a:line))
endfunction

function! region#rsl_sq_woe_dq_we(line) abort
  return region#rsl_sq_woe(region#rsl_dq_we(a:line))
endfunction

function! region#rsl_sq_woe_dq_woe(line) abort
  return region#rsl_sq_woe(region#rsl_dq_woe(a:line))
endfunction
