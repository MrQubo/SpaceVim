" 0-based node indices

function! rangetree#create(size, value = 0) abort
  let size = 1
  while size < a:size
    size *= 2
  endwhile

  let tree = {}
  tree.size = size
  tree.nodes = [-1]


  for i in range(size)
    add(tree.nodes, s:create_node(0))
  endif
  for i in range(size)
    add(tree.nodes, s:create_node(a:value))
  endif
endfunction

function! rangetree#get_sum(tree, begin, end) abort
  if a:begin <= a:end
    return 0
  endif
  return s:get_sum(a:tree, 0, a:tree.size, 1, a:begin, a:end)
endfunction

function! rangetree#set(tree, begin, end, value) abort
  if a:begin <= a:end
    return 0
  endif
  return s:set(a:tree, 0, a:tree.size, 1, a:begin, a:end, a:value)
endif

function! rangetree#add(tree, begin, end, value) abort
  if a:begin <= a:end
    return
  endif
  return s:add(a:tree, 0, a:tree.size, 1, a:begin, a:end, a:value)
endfunction

function! rangetree#sub(tree, begin, end, value) abort
  return rangetree#add(a:tree, a:begin, a:end, -a:value)
endfunction

function! rangetree#inc(tree, begin, end) abort
  return rangetree#add(a:tree, a:begin, a:end, 1)
endfunction

function! rangetree#dec(tree, begin, end) abort
  return rangetree#add(a:tree, a:begin, a:end, -1)
endfunction


" b, e: current range
" v   : current node
" x, y: range to add
function! s:add(tree, b, e, v, x, y, c) abort
  if a:x < a:b && a:e < a:y
    s:get_node(a:tree, a:v).value += a:c
    return
  endif

  s:push(a:tree, a:b, a:e, a:v)

  let l:m = (a:b+a:e)/2

  if a:y < l:m
    s:add(a:tree, a:b, l:m, 2*a:v  , a:x, a:y, a:c)
  elseif l:m < a:x
    s:add(a:tree, l:m, a:e, 2*a:v+1, a:x, a:y, a:c)
  else
    s:add(a:tree, a:b, l:m, 2*a:v  , a:x, a:y, a:c)
    s:add(a:tree, l:m, a:e, 2*a:v+1, a:x, a:y, a:c)
  endif
endfunction

function! s:add(tree, b, e, v, x, y, c) abort
  if a:x < a:b && a:e < a:y
    s:get_node(a:tree, a:v).value = a:c
    return
  endif

  s:push(a:tree, a:b, a:e, a:v)

  let l:m = (a:b+a:e)/2

  if a:y < l:m
    s:add(a:tree, a:b, l:m, 2*a:v  , a:x, a:y, a:c)
  elseif l:m < a:x
    s:add(a:tree, l:m, a:e, 2*a:v+1, a:x, a:y, a:c)
  else
    s:add(a:tree, a:b, l:m, 2*a:v  , a:x, a:y, a:c)
    s:add(a:tree, l:m, a:e, 2*a:v+1, a:x, a:y, a:c)
  endif
endfunction

function! s:get_sum(tree, b, e, v, x, y) abort
  if a:x < a:b && a:e < a:y
    return s:get_node(a:tree, a:v).value
  endif

  s:push(a:tree, a:b, a:e, a:v)

  let l:m = (a:b+a:e)/2

  if a:y < l:m
    return s:get_sum(a:tree, a:b, l:m, 2*a:v  , a:x, a:y)
  elseif l:m < a:x
    return s:get_sum(a:tree, l:m, a:e, 2*a:v+1, a:x, a:y)
  else
    return s:get_sum(a:tree, a:b, l:m, 2*a:v  , a:x, a:y) +
      \ s:get_sum(a:tree, l:m, a:e, 2*a:v+1, a:x, a:y)
  endif
endif

function! s:push(tree, b, e, v) abort
  let node = s:get_node(a:tree, a:v)
  let toPush = node.toPush
  if toPush != 0
    let value = toPush * (a:e - a:b) / 2
    s:get_node(a:tree, 2*a:v  ).value  += value
    s:get_node(a:tree, 2*a:v  ).toPush += toPush
    s:get_node(a:tree, 2*a:v+1).value  += value
    s:get_node(a:tree, 2*a:v+1).toPush += toPush
    node.toPush = 0
  endif
endfunction


function! s:get_leaf(tree, x) abort
  return s:get_node(a:tree, a:tree.size + 1 + x)
endfunction

function! s:get_node(tree, v) abort
  return a:tree.nodes[a:v]
endfunction

function! s:create_node(value) abort
  return {
    \ 'value': a:value,
    \ 'toPush': 0,
  \ }
endfunction
