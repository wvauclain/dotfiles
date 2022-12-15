" @<initialize-vim-plug
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ~/.config/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif
" >@initialize-vim-plug

call plug#begin('~/.config/nvim/plugged')
" @<packages/tmux
Plug 'christoomey/vim-tmux-navigator'
" >@packages/tmux
" @<packages/gruvbox
Plug 'gruvbox-community/gruvbox' " The best colorscheme ever
" >@packages/gruvbox
" @<packages/rust
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
" >@packages/rust
" @<packages/fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" >@packages/fzf
" @<packages/signify
Plug 'mhinz/vim-signify'
" >@packages/signify
" @<packages/tpope
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
" >@packages/tpope
" @<packages/polyglot
" Plug 'sheerun/vim-polyglot'
" >@packages/polyglot
Plug 'vimwiki/vimwiki'
call plug#end()

" @<settings/misc
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
" >@settings/misc

" @<options/gruvbox
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_contrast_light = 'hard'
let g:gruvbox_italic=1
let g:gruvbox_invert_selection=0

colorscheme gruvbox
set background=dark
" >@options/gruvbox


let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.wiki'}]

let g:vimwiki_global_ext = 0
