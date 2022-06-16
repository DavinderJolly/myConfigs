command -nargs=1 Pxtorem call s:PXtoREM(<f-args>)

function s:PXtoREM(...)
  let l:foo = string((a:1 - 16) / 16.0 + 1) . "rem"
  let @"=l:foo
  echo l:foo . " Coppied to clipboard"
endfunction
