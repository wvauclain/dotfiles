" Set how I like my indents
setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
let b:sleuth_automatic = 0

" Turn on spellcheck
setlocal spell! spelllang=en_us

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !texclear %

" Pick from snippets
command! Templates call fzf#run({
            \    'source': 'ls $HOME/Nextcloud/templates/latex',
            \    'options': [
            \        '--reverse',
            \        '--prompt', 'Template: ',
            \        '--preview', 'bat --style=numbers --color=always --line-range :500 $HOME/Nextcloud/templates/latex/{}'
            \    ],
            \    'sink': '%!cd $HOME/Nextcloud/templates/latex/ && cat'
            \})

" Special symbols:
inoremap <localleader>\| {\textbar}
" Word count:
map <leader>w :w !detex \| wc -w<CR>
" Text formatting
inoremap <localleader>tb \textbf{}<++><Esc>T{i
inoremap <localleader>ti \textit{}<++><Esc>T{i
inoremap <localleader>tt \texttt{}<++><Esc>T{i
inoremap <localleader>te \emph{}<++><Esc>T{i
inoremap <localleader>ts \textsc{}<++><Esc>T{i
inoremap <localleader>tu \underline{}<++><Esc>T{i
" Environments
inoremap <localleader>be \begin{enumerate}[]<Enter>\item <++><Enter>\end{enumerate}<Enter><Enter><++><Esc>4k$i
inoremap <localleader>bi \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
inoremap <localleader>bf \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter>\end{frame}<Enter><Enter><++><Esc>5kf{a
inoremap <localleader>ba \begin{align*}<Enter><Enter>\end{align*}<Enter><++><Esc>2kia<Esc>==$xA
inoremap <localleader>bd \begin{definition}<Enter><Enter>\end{definition}<Enter><++><Esc>2kia<Esc>==$xA
inoremap <localleader>bt \begin{theorem}<Enter><Enter>\end{theorem}<Enter><++><Esc>2kia<Esc>==$xA
inoremap <localleader>br \begin{remark}<Enter><Enter>\end{remark}<Enter><++><Esc>2kia<Esc>==$xA
inoremap <localleader>bp \begin{proof}<Enter><Enter>\end{proof}<Enter><++><Esc>2kia<Esc>==$xA
inoremap <localleader>bc \begin{corollary}<Enter><Enter>\end{corollary}<Enter><++><Esc>2kia<Esc>==$xA
" Math mode
inoremap <localleader>mf \frac{}{<++>}<++><Esc>2F{a
inoremap <localleader>mb \mathbb{}<++><Esc>F{a
inoremap <localleader>mv \mathbf{}<++><Esc>F{a
inoremap <localleader>m( \left(
inoremap <localleader>m) \right)
inoremap <localleader>mk \mathbb{K}
inoremap <localleader>mq \mathbb{Q}
inoremap <localleader>mr \mathbb{R}
inoremap <localleader>mc \mathbb{C}
inoremap <localleader>mz \mathbb{Z}
inoremap <localleader>mn \mathbb{N}
inoremap <localleader>m+ \mathbb{Z^+}
inoremap <localleader>mp \mathcal{P}
" Sections
inoremap <localleader>s1 \section{}<++><Esc>F{a
inoremap <localleader>s2 \subsection{}<++><Esc>F{a
" Other common tex macros
inoremap <localleader>li <Enter>\item<Space>


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
