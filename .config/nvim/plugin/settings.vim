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
