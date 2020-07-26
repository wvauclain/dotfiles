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
