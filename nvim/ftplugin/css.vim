command -nargs=1 Pxtorem call s:PXtoREM(<f-args>)

function s:PXtoREM(...)
  let l:result = string((a:1 - 16) / 16.0 + 1) . "rem"
  let @"=l:result
  echo l:result . " Coppied to clipboard"
endfunction
