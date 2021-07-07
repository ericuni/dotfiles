"===========================Chinese Punctuation: ctrl-s or :%call CheckChineseMark ==================
map <C-S> :call CheckChineseMark()<CR>
imap <C-S> <ESC>:call CheckChineseMark()<CR>
vmap <C-S> <ESC>:call CheckChineseMark()<CR>

function! CheckChineseMark()
  "check one by one
  if search('。')
    let s:line=search('。')
    execute s:line . "s/。/\./g"
  endif

  if search('，')
    let s:line=search('，')
    execute s:line . "s/，/,/g"
  endif

  if search('；')
    let s:line=search('；')
    execute s:line . "s/；/,/g"

  endif

  if search('？')
    let s:line=search('？')
    execute s:line . "s/？/?/g"
  endif

  if search('：')
    let s:line=search('：')
    execute s:line . "s/：/\:/g"
  endif

  if search('‘')
    let s:line=search('‘')
    execute s:line . "s/‘/\'/g"
  endif

  if search('’')
    let s:line=search('’')
    execute s:line . "s/’/\'/g"
  endif

  if search('”')
    let s:line=search('”')
    execute s:line . "s/”/\"/g"
  endif

  if search('“')
    let s:line=search('“')
    execute s:line . "s/“/\"/g"
  endif

  if search('《')
    let s:line=search('《')
    execute s:line . "s/《/\</g"
  endif

  if search('》')
    let s:linie=search('》')
    execute s:line . "s/》/\>/g"
  endif

  if search('——')
    let s:line=search('——')
    execute s:line . "s/——/-/g"
  endif

  if search('）')
    let s:line=search('）')
    execute s:line . "s/）/\)/g"
  endif

  if search('（')
    let s:line=search('（')
    execute s:line . "s/（/\(/g"
  endif

  if search('……')
    let s:line=search('……')
    execute s:line . "s/……/^/g"
  endif

  if search('￥')
    let s:line=search('￥')
    execute s:line . "s/￥/$/g"
  endif

  if search('！')
    let s:line=search('！')
    execute s:line . "s/！/!/g"
  endif

  if search('·')
    let s:line=search('·')
    execute s:line . "s/·/`/g"
  endif

  if search('、')
    let s:line=search('、')
    execute s:line . "s/、/,/g"
  endif

  if search('Θ')
    let s:line=search('Θ')
    execute s:line . "s/Θ/Theta/g"
  endif

  if search('ε')
    let s:line=search('ε')
    execute s:line . "s/ε/epsilon/g"
  endif

  if search('Ω')
    let s:line=search('Ω')
    execute s:line . "s/Ω/Omega/g"
  endif

  if search('∈')
    let s:line=search('∈')
    execute s:line . "s/∈/in/g"
  endif

  if search('≤')
    let s:line=search('≤')
    execute s:line . "s/≤/leq/g"
  endif

  if search('≥')
    let s:line=search('≥')
    execute s:line . "s/≥/geq/g"
  endif

  if search('≠')
    let s:line=search('≠')
    execute s:line . "s/≠/neq/g"
  endif

  if search('≈')
    let s:line=search('≈')
    execute s:line . "s/≈/approx/g"
  endif
endfunction
"===========================Chinese Punctuation: ctrl-s or :%call CheckChineseMark ==================

