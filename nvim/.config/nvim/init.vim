" Initialize vim plug
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ~/.config/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

" Install plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'fatih/vim-go'
Plug 'gruvbox-community/gruvbox' " The best colorscheme ever
Plug 'junegunn/fzf.vim'
Plug 'luochen1990/rainbow'
Plug 'mhinz/vim-signify' " Show git diffs in the gutter
Plug 'psf/black', { 'tag': '19.10b0' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'rust-lang/rust.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'cespare/vim-toml'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'sirver/ultisnips'
call plug#end()

" Neovim settings
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

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" Better tabbing
vnoremap < <gv
vnoremap > >gv
