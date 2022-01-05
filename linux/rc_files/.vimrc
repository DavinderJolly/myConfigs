" Vim plugins
    call plug#begin('~/.vim/plugged')

" Adding emmet-vim
    Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'jsx', 'tsx'] }

" Vim Prettier plugin
    Plug 'prettier/vim-prettier', {
        \ 'do': 'npm install --frozen-lockfile --production',
        \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

" Linter plugin
    Plug 'vim-syntastic/syntastic'

" Status bar plugin
    Plug 'itchyny/lightline.vim'

" Discord presence (commented when in wsl)
"    Plug 'vimsence/vimsence'


    call plug#end()

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

" Adding mouse support
    set mouse=a

" remove relative numbers in insert mode
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber

" Automatically Delete Trailing Whitespace on save.
        autocmd BufWritePre * %s/\s\+$//e

" Format HTML and CSS files on save.
    autocmd BufWritePre *.{html,css,js,ts} call FormatPrettier()
    function! FormatPrettier()
        :Prettier
        :norm Go
    endfunction

" Format Python files on save
    autocmd BufWritePre *.py :norm gggqG``zz

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

" Set Linters
    let g:syntastic_python_checkers = ['flake8']
    let g:syntastic_python_flake8_args = "--ignore=E203 --max-line-length=88"
    let g:syntastic_javascript_checkers = ['eslint']
    let g:syntastic_javascript_eslint_args = "--rule \"no-var: error\" --parser-options=ecmaVersion:12"

" Syntastic configuration
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0


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

" Lightline fix and config
    set noshowmode
    let g:lightline = {
        \ 'colorscheme': 'one',
        \ }


" Setting up discord precense
    let g:vimsence_small_text = 'Vim'
    let g:vimsence_small_image = 'vim'
    let g:vimsence_editing_state = "in Vim"
    let g:vimsence_file_explorer_text = 'In Explorer'
    let g:vimsence_file_explorer_details = 'Looking for files'
