" vim: set fenc=utf8 ff=unix ts=4 sts=4 sw=4 et nowrap ft=vim:

let g:monday#words   = ''
let g:monday#numbers = ''

function monday#AddWordPair(word1, word2)
  let w10 = tolower(a:word1)
  let w11 = toupper(matchstr(a:word1, '.')) . matchstr(w10, '.*', 1) 
  let w12 = toupper(a:word1)

  let w20 = tolower(a:word2)
  let w21 = toupper(matchstr(a:word2, '.')) . matchstr(w20, '.*', 1) 
  let w22 = toupper(a:word2)

  let g:monday#words = g:monday#words . w10 . ':' . w20 . ','
  let g:monday#words = g:monday#words . w11 . ':' . w21 . ','
  let g:monday#words = g:monday#words . w12 . ':' . w22 . ','
endfunction

function monday#AddWord(word1)
	if len(a:word1) == 2
		call monday#AddWordPair(a:word1[0], a:word1[1])
		call monday#AddWordPair(a:word1[1], a:word1[0])
	elseif len(a:word1) > 2
		for i in range(0,len(a:word1) - 1)
			let c = i + 1
			let c = len(a:word1) == c ? 0 : c
			call monday#AddWordPair(a:word1[i], a:word1[c])
		endfor
	endif
endfunction

function monday#AddNumberSuffix(number, suffix)
  let s0 = tolower(a:suffix)
  let s1 = toupper(a:suffix)

  let g:monday#numbers = g:monday#numbers . 's' . a:number . s0 . ','
  let g:monday#numbers = g:monday#numbers . 'l' . a:number . s1 . ','
endfunction

function monday#FindNrSuffix(w, nr)
  let n1 = matchstr(a:nr, '\d\>')
  let n2 = matchstr(a:nr, '\d\d\>')

  let m = matchstr(a:w, '\D\+', 1)
  let m = matchstr(g:monday#numbers, '[sl]\d\+' . m)
  let m = matchstr(m, '.')

  let c1 = (n1 != "") ? match(g:monday#numbers, m . n1 . '\D\+') : -1
  let c2 = (n2 != "") ? match(g:monday#numbers, m . n2 . '\D\+') : -1

  if c2 >= 0
    return matchstr(g:monday#numbers, '\D\+\>', c2)
  else
    return matchstr(g:monday#numbers, '\D\+\>', c1)
  endif
endfunction

function monday#GotoFirstNonblank()
  call cursor(0, col('.') - 1)
  call search('\S')
endfunction

function monday#Increase()
  let N = (v:count < 1) ? 1 : v:count
  let i = 0
  while i < N
    let w = expand('<cWORD>')
    if g:monday#words =~# '\<' . w . ':'
      let n = match(g:monday#words, w . ':\i\+\C')
      let n = match(g:monday#words, ':', n)
      let a = matchstr(g:monday#words, '\i\+', n)
      call monday#GotoFirstNonblank()
      execute "normal! ciw" . a
    elseif w =~# '\<-\?\d\+\D\+\>' && g:monday#numbers =~# '\d\+' . matchstr(w, '\D\+', 1) . ','
      let a = matchstr(w, '-\?\d\+')
      let a = a + 1
      let s = monday#FindNrSuffix(w, a)
      call monday#GotoFirstNonblank()
      execute "normal! ciW" . a . s
    else
      execute "normal! \<c-a>"
    endif
    let i = i + 1
  endwhile
endfunction

function monday#Decrease()
  let N = (v:count < 1) ? 1 : v:count
  let i = 0
  while i < N
    let w = expand('<cWORD>')
    if g:monday#words =~# ':' . w . '\>'
      let n = match(g:monday#words, '\i\+\C:' . w)
      let a = matchstr(g:monday#words, '\i\+', n)
      call monday#GotoFirstNonblank()
      execute "normal! ciw" . a
    elseif w =~# '\<-\?\d\+\D\+\>' && g:monday#numbers =~# '\d\+' . matchstr(w, '\D\+', 1) . ','
      let a = matchstr(w, '-\?\d\+')
      let a = a - 1
      let s = monday#FindNrSuffix(w, a)
      call monday#GotoFirstNonblank()
      execute "normal! ciW" . a . s
    else
      execute "normal! \<c-x>"
    endif
    let i = i + 1
  endwhile
endfunction


