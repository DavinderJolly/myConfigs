" sorround selection with quotes
vnoremap s" c"<C-r>""<ESC>
vnoremap s' c'<C-r>"'<ESC>

" sorround selection with brackets
vnoremap s( c(<C-r>")<ESC>
vnoremap s{ c{<C-r>"}<ESC>
vnoremap s[ c[<C-r>"]<ESC>

" Copy to system clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from system clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Open Current File in browser
command OpenInBrave :!brave %:p
