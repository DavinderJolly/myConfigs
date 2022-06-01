" Few basics:
syntax on
set encoding=utf-8
set number relativenumber
set nocompatible
set splitright

" Turn tabs to spaces
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Settings for Makefiles
autocmd FileType make call MakefileSettings()

function! MakefileSettings()
    setlocal noexpandtab
    setlocal nosmartindent
endfunction

" Adding mouse support
set mouse=a

" Remove relative numbers in insert mode
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" Automatically Delete Trailing Whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

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

" Recursive search
" Tab complete for every file related tasks
set path+=**

" Display all matches on tab complete
set wildmenu

" File explorer settings
let g:netrw_banner=0 " removes huge banner
let g:netrw_liststyle=3 " fix view to tree
let g:netrw_browse_split=4 " opens in prior window
let g:netrw_altv=1 " opens splits to the right



