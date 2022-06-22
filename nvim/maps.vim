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

" Paste from system clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Move current line around using Alt + j or k
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Open Current File in browser
command OpenInBrave :!brave %:p
