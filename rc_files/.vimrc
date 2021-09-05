
" Few basics:
	syntax on
	set encoding=utf-8
	set number relativenumber
    set nocompatible

" Turn tabs to spaces
	set tabstop=4 softtabstop=4
	set shiftwidth=4
    set expandtab
	set smartindent

" Automatically Delete Trailing Whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

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

" Cursor fix
    if &term =~ '^xterm'
        " enter vim
        autocmd VimEnter * silent !echo -ne "\e[1 q"
        " oherwise
        let &t_EI .= "\<Esc>[1 q"
        " insert mode
        let &t_SI .= "\<Esc>[5 q"
        " 1 or 0 -> blinking block
        " 2 -> solid block
        " 3 -> blinking underscore
        " 4 -> solid underscore
        " Recent versions of xterm (282 or above) also support
        " 5 -> blinking vertical bar
        " 6 -> solid vertical bar
        " leave vim
        autocmd VimLeave * silent !echo -ne "\e[5 q"
    endif

