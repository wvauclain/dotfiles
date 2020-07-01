function RenameTmuxWindow()
  let filename = expand("%:t")
  if filename != ""
    call system("tmux rename-window 'nvim " . filename . "'")
  endif
endfunction

if exists("$TMUX")
  autocmd BufEnter * call RenameTmuxWindow()
  autocmd VimLeave * call system("tmux setw automatic-rename")
endif
