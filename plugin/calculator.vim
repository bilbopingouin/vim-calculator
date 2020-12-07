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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         CALCULATOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""
" Perform the calculation
"""""""""""""""""""""""""""""""""
function calculator#DoCalculate()
  :let l:operation = getline('.')
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

command! -nargs=0 CalcStop  :q

command! -nargs=0 Calculate :call calculator#DoCalculate()

command! -nargs=+ Calc      :execute ":echo ".<f-args>


"""""""""""""""""""""""""""""""""
" Maps
"""""""""""""""""""""""""""""""""

:imap <C-g>  <ESC>:Calculate<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         CONVERSIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""
" Convert unsigned hex to decimal
"""""""""""""""""""""""""""""""""
function! calculator#UnsignedHex2dec(hexvalue)
  return str2nr(a:hexvalue, 16)
endfunction


"""""""""""""""""""""""""""""""""
" Convert signed hex to decimal
"""""""""""""""""""""""""""""""""
function! calculator#SignedHex2dec(hexvalue, bitsize)
  return float2nr(eval('0x'.a:hexvalue)-pow(2,a:bitsize))
endfunction


"""""""""""""""""""""""""""""""""
" Convert unsigned decimal to hex
"""""""""""""""""""""""""""""""""
function! calculator#UnsignedDec2hex(decvalue, size)
  return printf("%0".a:size."x", a:decvalue)
endfunction


"""""""""""""""""""""""""""""""""
" Print result
"""""""""""""""""""""""""""""""""
function! calculator#EchoResult(value, fn, xtr)
  ":echo 'Function: '.a:fn
  ":echo a:value
  " Initial: nan
  :let l:result = (0.0 / 0.0)

  " unsigned hex to dec
  if a:fn ==# 'uHD'
    
    :let l:result = calculator#UnsignedHex2dec(a:value)

  " unsigned dec to hex
  elseif a:fn ==# 'uDH'

    if a:xtr == ''
      :let l:result = calculator#UnsignedDec2hex(a:value, '8')
    else
      :let l:result = calculator#UnsignedDec2hex(a:value, a:xtr/4)
    endif

  " signed dec to hex
  elseif a:fn ==# 'sDH'
    
    if a:xtr == ''
      :let l:size = 8
    else
      :let l:size = a:xtr/4
    endif
    :let l:result = calculator#UnsignedDec2hex(a:value, l:size)
    if len(l:result) > l:size
      :let l:rsize = len(l:result)
      :let l:result = l:result[l:rsize-l:size:-1]
    endif
    :let l:result = '0x'.l:result

  " signed hex to dec
  elseif a:fn ==# 'sHD'
    
    if a:xtr == ''
      :let l:size = 32
    else
      :let l:size = str2nr(a:xtr)
    endif
    :let l:result = calculator#SignedHex2dec(a:value, l:size)

  endif

  :echo '= '.l:result
endfunction


"""""""""""""""""""""""""""""""""
" Main application
"""""""""""""""""""""""""""""""""
function! calculator#Convert(...)
  :let l:function = 'sDH'
  :let l:value = '42'
  :let l:options = ''

  if a:0 == 1
    :let l:value = a:1
  elseif a:0 == 2
    :let l:function = a:1
    :let l:value = a:2
  elseif a:0 == 3
    :let l:function = a:1
    :let l:value = a:2
    :let l:options = a:3
  else
    :echoerr 'Please use as :Conv [uDH|sDH|uHD|sHD] NN [NBITS]'
    :return
  endif

  :call calculator#EchoResult(l:value, l:function, l:options)
endfunction


"""""""""""""""""""""""""""""""""
" Commands
"""""""""""""""""""""""""""""""""
command! -nargs=+ Convert :call calculator#Convert(<f-args>)
