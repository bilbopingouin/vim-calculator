"""
" calculator.vim
"
" author: bilbo pingouin
" date: 2020.07.09
"
"""

"""""""""""""""""""""""""""""""""
" Create a new swap buffer
"""""""""""""""""""""""""""""""""
function! s:CreateSwap()
   :new
   :setlocal buftype=nofile
   :setlocal bufhidden=hide
   :setlocal noswapfile
   :setlocal nobuflisted
 endfunction


"""""""""""""""""""""""""""""""""
" Perform the calculation
"""""""""""""""""""""""""""""""""
function calculator#DoCalculate()
  :let l:operation = getline('.')
  ":execute ":normal o= "
  ":execute ":normal o= a\=1+1"
  " :execute ":s/a/\\=(".l:operation.")/"
  ":execute ":echo \=".l:operation."<enter>"
  ":normal "=1+1<Enter>p
  :execute ":put =".l:operation
  :normal o
endfunction


"""""""""""""""""""""""""""""""""
" Main application
"""""""""""""""""""""""""""""""""
function calculator#Calculator()
  :call s:CreateSwap()
endfunction



"""""""""""""""""""""""""""""""""
" Commands
"""""""""""""""""""""""""""""""""

command! -nargs=0 CalcStart :call calculator#Calculator()

command! -nargs=0 Calculate :call calculator#DoCalculate()

command! -nargs=0 CalcStop  :q


"""""""""""""""""""""""""""""""""
" Maps
"""""""""""""""""""""""""""""""""

:imap <C-g>  <ESC>:Calculate<CR>
