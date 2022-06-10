" Few basics "{{{
syntax on
set encoding=utf-8
set number relativenumber
set nocompatible
set splitright
set hlsearch
set scrolloff=10
set lazyredraw

" Adding mouse support
set mouse=a

" Turn tabs to spaces
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Remove relative numbers in insert mode
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" Automatically Delete Trailing Whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" Auto load vimrc view
autocmd BufWinLeave .vimrc mkview
autocmd BufWinEnter .vimrc silent loadview

"}}}

" Custom Keymaps "{{{


" Sorround selection with quotes
vnoremap s" c"<C-r>""<ESC>
vnoremap s' c'<C-r>"'<ESC>

" Sorround selection with brackets
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

"}}}

" File specific settings "{{{

" Settings for Makefiles
autocmd FileType make call MakefileSettings()

function! MakefileSettings()
    setlocal noexpandtab
    setlocal nosmartindent
endfunction

" Auto close brackets and strings
function! AutoCloseBracketAndStrings()
    inoremap <buffer> " ""<left>
    inoremap <buffer> ' ''<left>
    inoremap <buffer> ( ()<left>
    inoremap <buffer> [ []<left>
    inoremap <buffer> { {}<left>
    inoremap <buffer> {<CR> {<CR>}<ESC>O
endfunction

autocmd FileType html,css,scss,javascript call AutoCloseBracketAndStrings()

"}}}

" File browsing and searching "{{{
" Tab complete for every file related tasks
set path+=**
set wildignore+=*/node_modules/*

" Display all matches on tab complete
set wildmenu

" File explorer settings
let g:netrw_banner=0 " removes huge banner
let g:netrw_liststyle=3 " fix view to tree
let g:netrw_browse_split=4 " opens in prior window
let g:netrw_altv=1 " opens splits to the right

"}}}
