" indent with 8-space tabs in Go
let b:sleuth_automatic = 0
set noexpandtab
set tabstop=8
set shiftwidth=8
set softtabstop=8

" Fix renaming
let g:go_rename_command = 'gopls'

" Set shortcuts
map <localleader>i :GoImports<CR>
map <localleader>f :GoFmt<CR>
map <localleader>b :GoBuild<CR>
map <localleader>r :GoRename<CR>
