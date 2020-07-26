function! InGitRepo(...)
  let path = get(a:, 1, expand('%:p:h'))

  call system("cd " . shellescape(path) . " && git status")
  return !v:shell_error
endfunction

function! GitRepo()
  let path = system("git rev-parse --show-toplevel")
  if v:shell_error
    throw "Not in a git directory"
  endif
  return path
endfunction

