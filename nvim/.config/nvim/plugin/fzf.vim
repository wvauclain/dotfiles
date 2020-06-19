function! RipgrepFzfIn(dir, query, fullscreen)
  let cwd = getcwd()
  execute "cd " . a:dir

  let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --smart-case -- %s || true'

  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)

  execute "cd " . cwd
endfunction

command! -nargs=* -bang Rg call RipgrepFzfIn(getcwd(), <q-args>, <bang>1)
command! -nargs=* -bang GRg call RipgrepFzfIn(GitRepo(), <q-args>, <bang>1)

function! ControlP()
  if InGitRepo()
    exec "GitFiles"
  else
    exec "Files"
  endif
endfunction
noremap <C-p> :call ControlP()<CR>
