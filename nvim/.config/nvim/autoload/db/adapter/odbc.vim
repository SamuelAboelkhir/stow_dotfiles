function! db#adapter#odbc#canonicalize(url) abort
  return a:url
endfunction

function! db#adapter#odbc#command(url) abort
  let l:dsn = substitute(a:url, '^odbc://', '', '')
  return ['isql', '-v', -b', l:dsn]
endfunction

function! db#adapter#odbc#interactive(url) abort
  let l:dsn = substitute(a:url, '^odbc://', '', '')
  return ['isql', '-v', '-b', l:dsn]
endfunction
