" Vim plugin file
"
" Maintainer:   Stefan Karlsson <stefan.74@comhem.se>
" Last Change:  6 May 2005
"
" Purpose:      To make <ctrl-a> and <ctrl-x> operate on the names of weekdays
"               and months. Also to make them operate on text such as 1st, 2nd,
"               3rd, and so on.
"
" TODO:         Although it is possible to add any words you like as
"               increase/decrease pairs, problems will arise when one word has
"               two or more possible successors (or predecessors). For instance,
"               the 4th month is named "April" in both English and Swedish, but
"               its successor is called "May" and "Maj", respectively.
"
"               So, in order for the script to be generally applicable, I must
"               find a way to toggle between all possible increments/decrements
"               of a word.


if exists('loaded_monday') || &compatible
  finish
endif
let loaded_monday = 1

let g:monday#words   = ''
let g:monday#numbers = ''


call monday#AddWord( ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'] )
call monday#AddWord( ['january', 'february', 'march', 'april', 'may', 'june', 'july', 'august', 'september', 'october', 'november', 'december' ] )

call monday#AddWord( ["true", "false"] )
call monday#AddWord( ["yes", "no"] )
call monday#AddWord( ["on", "off"] )

call monday#AddWord( ["enable", "disable"] )
call monday#AddWord( ["public", "protected", "private"] )


call monday#AddNumberSuffix('11', 'th')
call monday#AddNumberSuffix('12', 'th')
call monday#AddNumberSuffix('13', 'th')

call monday#AddNumberSuffix( '0', 'th')
call monday#AddNumberSuffix( '1', 'st')
call monday#AddNumberSuffix( '2', 'nd')
call monday#AddNumberSuffix( '3', 'rd')
call monday#AddNumberSuffix( '4', 'th')
call monday#AddNumberSuffix( '5', 'th')
call monday#AddNumberSuffix( '6', 'th')
call monday#AddNumberSuffix( '7', 'th')
call monday#AddNumberSuffix( '8', 'th')
call monday#AddNumberSuffix( '9', 'th')

nmap <silent> <c-a> :<c-u>call monday#Increase()<cr>
nmap <silent> <c-x> :<c-u>call monday#Decrease()<cr>


