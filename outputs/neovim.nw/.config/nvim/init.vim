" Initialize vim plug
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ~/.config/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif
call plug#begin('~/.config/nvim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'gruvbox-community/gruvbox' " The best colorscheme ever
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'vim-scripts/noweb.vim--McDermott'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
call plug#end()
filetype plugin on " Enable my individual filetype plugins
let mapleader = " "
let maplocalleader = ","
set autoread " Reload file when changed by an outside tool
set clipboard=unnamedplus " Use the global clipboard
set list " Render leading and trailing whitespace characters
set listchars=tab:<->,space:· " Set the whitespace characters to be rendered
set mouse=a " Enable mouse support in every mode
set nohlsearch " Don't highlight after searching
set number relativenumber " Use relative line numbering
set splitbelow splitright " Splits open at the bottom and right
set updatetime=100 " Time until swap file is written to disk
set wildmode=longest:full,full " Make ex-mode tab completion work more predictably

" Basic key bindings
map <leader>o :setlocal spell! spelllang=en_us<CR>
map <localleader>c :w! \| !compiler <c-r>%<CR>
map <localleader>p :!opout <c-r>%<CR><CR>
nnoremap S :%s//g<Left><Left>

" Don't copy to the clipboard when using 'c'
nnoremap c "_c

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd BufRead,BufNewFile *.h set filetype=c

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Set filetypes
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex

" Read rc files properly. We have to do this check for &ft == 'rc' since if it
" has a shebang then rcshell.vim will already detect that the file is
" 'rcshell' and setting it again messes up syntax highlighting
au BufRead,BufNewFile *.rc if &ft == 'rc' | set filetype=rcshell | endif

" From LukeSmithxyz
inoremap <localleader><localleader> <Esc>/<++><Enter>"_c4l
vnoremap <localleader><localleader> <Esc>/<++><Enter>"_c4l
map <localleader><localleader> <Esc>/<++><Enter>"_c4l

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

function! RipgrepFzfIn(dir, query, fullscreen, exact)
  let cwd = getcwd()
  execute "cd " . a:dir

  if a:exact
    let fixed_strings="--fixed-strings"
  else
    let fixed_strings=""
  endif

  let command_fmt = 'rg ' . fixed_strings . ' --hidden --column --line-number --no-heading --color=always --smart-case -- %s || true'

  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)

  execute "cd " . cwd
endfunction

command! -nargs=* -bang Rg call RipgrepFzfIn(getcwd(), <q-args>, <bang>1, 0)
command! -nargs=* -bang GRg call RipgrepFzfIn(GitRepo(), <q-args>, <bang>1, 0)

command! -nargs=* -bang Rs call RipgrepFzfIn(getcwd(), <q-args>, <bang>1, 1)
command! -nargs=* -bang GRs call RipgrepFzfIn(GitRepo(), <q-args>, <bang>1, 1)

function! ControlP()
  if InGitRepo()
    exec "GitFiles"
  else
    exec "Files"
  endif
endfunction
noremap <C-p> :call ControlP()<CR>

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

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-/> :TmuxNavigatePrevious<cr>
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_contrast_light = 'hard'
let g:gruvbox_italic=1
let g:gruvbox_invert_selection=0

colorscheme gruvbox
set background=dark
" set termguicolors
au BufRead,BufNewFile *.nw    set filetype=noweb
