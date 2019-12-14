" Adapted from LukeSmithXYZ's voidrice

let mapleader =","

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

" Allow toggling light and dark theme
map <leader>cl :set background=light<CR>
map <leader>cd :set background=dark<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is unlike vim defaults.
set splitbelow splitright

" Check file in shellcheck:
autocmd FileType sh,bash map <leader>s :!clear && shellcheck %<CR>

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" Render leading and trailing whitespace characters
set list

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Navigating with guides
inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
map <leader><leader> <Esc>/<++><Enter>"_c4l

"""LATEX
" Special symbols:
autocmd FileType tex inoremap ,\| {\textbar}
" Word count:
autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
" Text formatting
autocmd FileType tex inoremap ,te \emph{}<++><Esc>T{i
autocmd FileType tex inoremap ,tb \textbf{}<++><Esc>T{i
autocmd FileType tex inoremap ,ti \textit{}<++><Esc>T{i
" Environments
autocmd FileType tex inoremap ,be \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ,bi \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ,ba \begin{align*}<Enter><Enter>\end{align*}<Enter><++><Esc>2kia<Esc>==$xA
" Math mode
autocmd FileType tex inoremap ,mf \frac{}{<++>}<++><Esc>2F{a
autocmd FileType tex inoremap ,mb \mathbb{}<++><Esc>F{a
autocmd FileType tex inoremap ,m( \left(
autocmd FileType tex inoremap ,m) \right)
" Other common tex macros
autocmd FileType tex inoremap ,li <Enter>\item<Space>



" autocmd FileType tex inoremap ,ref \ref{}<Space><++><Esc>T{i
" autocmd FileType tex inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
" autocmd FileType tex inoremap ,ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
" autocmd FileType tex inoremap ,can \cand{}<Tab><++><Esc>T{i
" autocmd FileType tex inoremap ,con \const{}<Tab><++><Esc>T{i
" autocmd FileType tex inoremap ,v \vio{}<Tab><++><Esc>T{i
" autocmd FileType tex inoremap ,a \href{}{<++>}<Space><++><Esc>2T{i
" autocmd FileType tex inoremap ,sc \textsc{}<Space><++><Esc>T{i
" autocmd FileType tex inoremap ,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
" autocmd FileType tex inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
" autocmd FileType tex inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
" autocmd FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
" autocmd FileType tex inoremap ,st <Esc>F{i*<Esc>f}i
" autocmd FileType tex inoremap ,beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
" autocmd FileType tex inoremap ,up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
" autocmd FileType tex nnoremap ,up /usepackage<Enter>o\usepackage{}<Esc>i
" autocmd FileType tex inoremap ,tt \texttt{}<Space><++><Esc>T{i
" autocmd FileType tex inoremap ,bt {\blindtext}
" autocmd FileType tex inoremap ,nu $\varnothing$
" autocmd FileType tex inoremap ,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
" autocmd FileType tex inoremap ,rn (\ref{})<++><Esc>F}i
