" Adapted from LukeSmithXYZ's voidrice

let mapleader = " "
let maplocalleader = ","

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-signify'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'GEverding/vim-hocon'
Plug 'junegunn/fzf'
Plug 'rhysd/vim-clang-format'
Plug 'jremmen/vim-ripgrep'
call plug#end()

set go=a
set mouse=a
set nohlsearch
set clipboard=unnamedplus

set expandtab
set shiftwidth=4
set softtabstop=4

let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_contrast_light = 'hard'
colorscheme gruvbox
set background=dark

" Some basics:
nnoremap c "_c
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber

" Enable autocompletion:
set wildmode=longest,list,full

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Allow toggling light and dark theme
map <leader>cl :set background=light<CR>
map <leader>cd :set background=dark<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Open fuzzy-finder
map <leader>f :FZF<CR>

" Splits open at the bottom and right, which is unlike vim defaults.
set splitbelow splitright

" Check file in shellcheck:
autocmd FileType sh,bash map <leader>s :!clear && shellcheck %<CR>

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
map <localleader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
map <localleader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" Render leading and trailing whitespace characters
set list

" Reload file when changed by an outside tool
set autoread

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Navigating with guides
inoremap <localleader><localleader> <Esc>/<++><Enter>"_c4l
vnoremap <localleader><localleader> <Esc>/<++><Enter>"_c4l
map <localleader><localleader> <Esc>/<++><Enter>"_c4l

"""LATEX
" Special symbols:
autocmd FileType tex inoremap <localleader>\| {\textbar}
" Word count:
autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
" Text formatting
autocmd FileType tex inoremap <localleader>tb \textbf{}<++><Esc>T{i
autocmd FileType tex inoremap <localleader>ti \textit{}<++><Esc>T{i
autocmd FileType tex inoremap <localleader>tt \texttt{}<++><Esc>T{i
autocmd FileType tex inoremap <localleader>te \emph{}<++><Esc>T{i
" Environments
autocmd FileType tex inoremap <localleader>be \begin{enumerate}[]<Enter>\item <++><Enter>\end{enumerate}<Enter><Enter><++><Esc>4k$i
autocmd FileType tex inoremap <localleader>bi \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap <localleader>ba \begin{align*}<Enter><Enter>\end{align*}<Enter><++><Esc>2kia<Esc>==$xA
autocmd FileType tex inoremap <localleader>bd \begin{definition}<Enter><Enter>\end{definition}<Enter><++><Esc>2kia<Esc>==$xA
autocmd FileType tex inoremap <localleader>bt \begin{theorem}<Enter><Enter>\end{theorem}<Enter><++><Esc>2kia<Esc>==$xA
autocmd FileType tex inoremap <localleader>br \begin{remark}<Enter><Enter>\end{remark}<Enter><++><Esc>2kia<Esc>==$xA
autocmd FileType tex inoremap <localleader>bp \begin{proof}<Enter><Enter>\end{proof}<Enter><++><Esc>2kia<Esc>==$xA
autocmd FileType tex inoremap <localleader>bc \begin{corollary}<Enter><Enter>\end{corollary}<Enter><++><Esc>2kia<Esc>==$xA
" Math mode
autocmd FileType tex inoremap <localleader>mf \frac{}{<++>}<++><Esc>2F{a
autocmd FileType tex inoremap <localleader>mb \mathbb{}<++><Esc>F{a
autocmd FileType tex inoremap <localleader>mv \mathbf{}<++><Esc>F{a
autocmd FileType tex inoremap <localleader>m( \left(
autocmd FileType tex inoremap <localleader>m) \right)
autocmd FileType tex inoremap <localleader>mk \mathbb{K}
autocmd FileType tex inoremap <localleader>mq \mathbb{Q}
autocmd FileType tex inoremap <localleader>mr \mathbb{R}
autocmd FileType tex inoremap <localleader>mc \mathbb{C}
autocmd FileType tex inoremap <localleader>mz \mathbb{Z}
autocmd FileType tex inoremap <localleader>mn \mathbb{N}
autocmd FileType tex inoremap <localleader>m+ \mathbb{Z^+}
" Sections
autocmd FileType tex inoremap <localleader>s1 \section{}<++><Esc>F{a
autocmd FileType tex inoremap <localleader>s2 \subsection{}<++><Esc>F{a
" Other common tex macros
autocmd FileType tex inoremap <localleader>li <Enter>\item<Space>



" autocmd FileType tex inoremap <localleader>ref \ref{}<Space><++><Esc>T{i
" autocmd FileType tex inoremap <localleader>tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
" autocmd FileType tex inoremap <localleader>ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
" autocmd FileType tex inoremap <localleader>can \cand{}<Tab><++><Esc>T{i
" autocmd FileType tex inoremap <localleader>con \const{}<Tab><++><Esc>T{i
" autocmd FileType tex inoremap <localleader>v \vio{}<Tab><++><Esc>T{i
" autocmd FileType tex inoremap <localleader>a \href{}{<++>}<Space><++><Esc>2T{i
" autocmd FileType tex inoremap <localleader>sc \textsc{}<Space><++><Esc>T{i
" autocmd FileType tex inoremap <localleader>chap \chapter{}<Enter><Enter><++><Esc>2kf}i
" autocmd FileType tex inoremap <localleader>sec \section{}<Enter><Enter><++><Esc>2kf}i
" autocmd FileType tex inoremap <localleader>ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
" autocmd FileType tex inoremap <localleader>sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
" autocmd FileType tex inoremap <localleader>st <Esc>F{i*<Esc>f}i
" autocmd FileType tex inoremap <localleader>beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
" autocmd FileType tex inoremap <localleader>up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
" autocmd FileType tex nnoremap <localleader>up /usepackage<Enter>o\usepackage{}<Esc>i
" autocmd FileType tex inoremap <localleader>tt \texttt{}<Space><++><Esc>T{i
" autocmd FileType tex inoremap <localleader>bt {\blindtext}
" autocmd FileType tex inoremap <localleader>nu $\varnothing$
" autocmd FileType tex inoremap <localleader>col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
" autocmd FileType tex inoremap <localleader>rn (\ref{})<++><Esc>F}i

""" Go
" indent with 8-space tabs in Go
autocmd BufRead,BufNewFile *.go set noexpandtab
autocmd BufRead,BufNewFile *.go set tabstop=8
autocmd BufRead,BufNewFile *.go set shiftwidth=8
autocmd BufRead,BufNewFile *.go set softtabstop=8
" Fix renaming
let g:go_rename_command = 'gopls'
" Set shortcuts
autocmd FileType go map <localleader>i :GoImports<CR>
autocmd FileType go map <localleader>f :GoFmt<CR>
autocmd FileType go map <localleader>b :GoBuild<CR>
autocmd FileType go map <localleader>r :GoRename<CR>

""" Ripgrep
let g:rg_derive_root = 'true'
