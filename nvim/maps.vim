" sorround selection with quotes
vnoremap s" c"<C-r>""<ESC>
vnoremap s' c'<C-r>"'<ESC>

" sorround selection with brackets
vnoremap s( c(<C-r>")<ESC>
vnoremap s{ c{<C-r>"}<ESC>
vnoremap s[ c[<C-r>"]<ESC>

command OpenInBrave :!brave %:p
