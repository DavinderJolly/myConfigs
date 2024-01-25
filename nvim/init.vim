" Fundamentals "{{{
" ---------------------------------------------------------------------

" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" stop loading config if it's on tiny or small
if !1 | finish | endif

set nocompatible
set nosc noru nosm
set number
set relativenumber
set splitright
syntax enable
set fileencodings=utf-8
set encoding=utf-8
set title
set autoindent
set background=dark
set nobackup
set nowritebackup
set hlsearch
set showcmd
set cmdheight=1
set laststatus=3
set scrolloff=10
set expandtab

" let loaded_matchparen = 1
set backupskip=/tmp/*,/private/tmp/*

" Add mouse support
set mouse=a

" incremental substitution (neovim)
if has('nvim')
  set inccommand=split
endif

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=

" Don't redraw while executing macros (good performance config)
set lazyredraw
" set showmatch
" How many tenths of a second to blink when matching brackets
" set mat=2
" Ignore case when searching
" set ignorecase
" Only do case sensitive search when using capital letters
" Needs ignorecase on
" set smartcase

" Be smart when using tabs ;)
set smarttab
" indents
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set ai "Auto indent
set si "Smart indent
set nowrap "No Wrap lines
set backspace=start,eol,indent

" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Add asterisks in block comments
set formatoptions+=r

" Automatically Delete Trailing Whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" Switch relative and absolute line numbers
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

"}}}

" Highlights "{{{
" ---------------------------------------------------------------------
set cursorline
"set cursorcolumn

" Set cursor line color on visual mode
highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Gray40

highlight LineNr cterm=NONE ctermfg=240 guifg=Gray40 guibg=#000000

augroup BgHighlight
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

if &term =~ "screen"
  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif


"}}}

" File types "{{{
" ---------------------------------------------------------------------
" JavaScript
au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.mdx set filetype=markdown
" Flow
au BufNewFile,BufRead *.flow set filetype=javascript
" Fish
au BufNewFile,BufRead *.fish set filetype=fish
" glsl Shaders
au BufNewFile,BufRead *.{vert,frag} set filetype=glsl

set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md

autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

"}}}

" Imports "{{{
" ---------------------------------------------------------------------
runtime ./plug.vim

if has('win32')
  runtime ./windows.vim
endif
if has('unix')
  runtime ./unix.vim
endif

runtime ./maps.vim
"}}}

" Syntax theme "{{{
" ---------------------------------------------------------------------

" true color
if exists("&termguicolors") && exists("&winblend")
  syntax enable
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
  set background=dark

" Theme setup
lua <<EOF

  require('onedark').setup {
    transparent=true,
  }

EOF

  colorscheme onedark
  runtime onedark
endif

"}}}

" Extras "{{{
" ---------------------------------------------------------------------
set exrc
"}}}

" vim: set foldmethod=marker foldlevel=0:
