" Set the CWD when entering a new window
autocmd BufEnter * execute "lcd " . expand("%:p:h")
