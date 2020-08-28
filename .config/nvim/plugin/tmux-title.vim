if !has('python3')
  echo "The tmux-title.vim plugin requires Python 3 support"
endif

python3 << EndPython3

from os.path import splitext

def ShortenFilename(filename: str, width: int = 15) -> str:
  root, ext = splitext(filename)

  width = width - len(ext)
  # I'm just going to assume that len(ext) < width
  root = (root[:width-1] + '>') if len(root) > width else root

  return root + ext

EndPython3

function RenameTmuxWindow()
  let filename = expand("%:t")
  if filename != ""
    call system("tmux rename-window 'nvim " . py3eval("ShortenFilename('" . filename . "')") . "'")
  endif
endfunction

if exists("$TMUX")
  autocmd BufEnter * call RenameTmuxWindow()
  autocmd VimLeave * call system("tmux setw automatic-rename")
endif
