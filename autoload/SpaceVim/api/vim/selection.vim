let s:self = {}

function! s:self.get_selected_text() abort
  let k_save = @k
  if s:self.is_visual()
    try
      normal! "kygv
      return @k
    finally
      let @k = k_save
    endtry
  else
    try
      normal! gv"ky
      return @k
    finally
      let @k = k_save
    endtry
  endif
endfunction

function! s:self.replace_selected_text(replacement) abort
  let k_save = @k
  if s:self.is_visual()
    try
      let @k = a:replacement
      normal! "kpgv
    finally
      let @k = k_save
    endtry
  else
    try
      let @k = a:replacement
      normal! gv"kp
    finally
      let @k = k_save
    endtry
  endif
endfunction

function! s:self.is_visual() abort
  return mode() == 'v' || mode() == 'V' || mode() == "\<C-V>"
endfunction


function! s:self.get_text_under_cursor(selector) abort
  if s:self.is_visual()
    return s:self.get_selected_text()
  else
    let left_sel_save = getpos("'<")
    let right_sel_save = getpos("'>")
    let pos_save = getpos('.')
    try
      execute "normal! vi" + a:selector
      return s:self.get_selected_text()
    finally
      execute "normal! \<ESC>"
      call setpos('.', pos_save)
      call setpos("'>", right_sel_save)
      call setpos("'<", left_sel_save)
    endtry
  endif
endfunction

function! s:self.replace_text_under_cursor(selector, replacement) abort
  if s:self.is_visual()
    return s:self.replace_selected_text(a:replacement)
  else
    let left_sel_save = getpos("'<")
    let right_sel_save = getpos("'>")
    let pos_save = getpos('.')
    try
      execute "normal! vi" + a:selector
      return s:self.replace_selected_text(a:replacement)
    finally
      execute "normal! \<ESC>"
      call setpos('.', pos_save)
      call setpos("'>", right_sel_save)
      call setpos("'<", left_sel_save)
    endtry
  endif
endfunction


function! SpaceVim#api#vim#selection#get() abort
    return deepcopy(s:self)
endfunction
