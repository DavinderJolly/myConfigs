if executable('black')
    setlocal formatprg=black\ -q\ -\ 2>\ nul
    setlocal formatexpr=
endif
