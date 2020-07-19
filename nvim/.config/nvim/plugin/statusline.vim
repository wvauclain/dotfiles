let g:statusline_mode_map = {
      \ 'c'  : 'COMMAND',
      \ 'i'  : 'INSERT',
      \ 'n'  : 'NORMAL',
      \ 'R'  : 'REPLACE',
      \ 'v'  : 'VISUAL',
      \ 'V'  : 'V-LINE',
      \ '' : 'V-BLOCK',
      \ }

function! statusline#current_mode()
  return g:statusline_mode_map[mode(1)] . " "
endfunction

" Define the user highlights

hi __root__ cterm=bold,italic ctermfg=167 ctermbg=239 gui=bold,italic guifg=#fb4934 guibg=#504945
hi __mode__ cterm=bold ctermfg=109 ctermbg=239 gui=bold guifg=#83a598 guibg=#504945
hi __file__ cterm=italic ctermfg=175 ctermbg=237 gui=italic guifg=#d3869b guibg=#3c3836
hi __modified__ cterm=bold ctermfg=142 ctermbg=237 gui=bold guifg=#b8bb26 guibg=#3c3836
hi __readonly__ cterm=bold ctermfg=208 ctermbg=237 gui=bold guifg=#fe8019 guibg=#3c3836
hi __fileinfo__ cterm=italic ctermfg=246 ctermbg=237 gui=italic guifg=#a89984 guibg=#3c3836
hi __filetype__ ctermfg=214 ctermbg=239 guifg=#fabd2f guibg=#504945
hi __currentline__ ctermfg=108 ctermbg=239 guifg=#8ec07c guibg=#504945
hi __columnnumber__ ctermfg=108 ctermbg=239 guifg=#8ec07c guibg=#504945
" hi __columnnumber__ ctermfg=214 ctermbg=237 guifg=#fabd2f guibg=#3c3836

" Reset the statusline
set statusline=
" Root indicator
if $USER == "root"
  set statusline+=%#__root__#
  set statusline+=\ ﮊROOTﮊ\ " Keep the trailing space
endif

" Current mode indicator
set statusline+=%#__mode__#
set statusline+=\ %{statusline#current_mode()}
set statusline+=%{&spell?'[SPELL]':''}

" File path, as typed or relative to current directory
set statusline+=%#__file__#
set statusline+=\ %F

" Modified indicator
set statusline+=%#__modified__#
set statusline+=%{&modified?'\ *':''}

" Read-only indicator
set statusline+=%#__readonly__#
set statusline+=%{&readonly?'\ []':''}

" Truncate line here
set statusline+=%<

" Separation point between left and right aligned items.
set statusline+=%=

set statusline+=%#__fileinfo__#
set statusline+=\ %{&fileencoding}
set statusline+=\ %{&fileformat}\ " Keep the trailing space

set statusline+=%#__filetype__#
set statusline+=\ %{&filetype!=#''?&filetype:'none'}

" Location of cursor line
set statusline+=%#__currentline__#
set statusline+=\ [%l/%L]

" Column number
set statusline+=%#__columnnumber__#
set statusline+=\ col:%3c\ " Keep the trailing space
