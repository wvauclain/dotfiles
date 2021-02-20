##
# zsh settings
##

# ls colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# history
HISTFILE="$XDG_DATA_HOME/zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
# setopt share_history          # share command history data

# setup functions
for file ("$XDG_CONFIG_HOME"/zsh/*.zsh); do
    source $file
done
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# setup completion
autoload -Uz compinit
compinit -u -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

##
# keybindings
##

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line

# lf file picker
_zlf() {
    emulate -L zsh
    local d=$(mktemp -d) || return 1
    {
        mkfifo -m 600 $d/fifo || return 1
        tmux split -bf zsh -c "exec {ZLE_FIFO}>$d/fifo; export ZLE_FIFO; exec lf" || return 1
        local fd
        exec {fd}<$d/fifo
        zle -Fw $fd _zlf_handler
    } always {
        rm -rf $d
    }
}
zle -N _zlf
bindkey '\ek' _zlf

_zlf_handler() {
    emulate -L zsh
    local line
    if ! read -r line <&$1; then
        zle -F $1
        exec {1}<&-
        return 1
    fi
    eval $line
    zle -R
}
zle -N _zlf_handler

##
# personal config
##

# aliases
alias ls='ls --color=tty'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias md='mkdir -p'
alias l='ls -lAh'
alias ll='ls -lh'
alias cd-git-root='cd $(git rev-parse --show-toplevel)'
if (( ${+commands[wget]} )); then
    alias wget='wget --hsts-file=/dev/null'
    alias mirror='wget -e robots=off -r -nc -np -R "index.html*"'
fi
if (( ${+commands[pacman]} )); then
    alias pacupg='sudo pacman -Syu'
    alias pacin='sudo pacman -S'
    alias pacrem='sudo pacman -Rns'
fi
if (( ${+commands[trizen]} )); then
    alias trupg='trizen -Syua'
    alias trin='trizen -S'
    alias trrem='trizen -Rns'
fi
alias fixkeyboard='setxkbmap -option caps:escape'
if (( ${+commands[youtube-dl]} )); then
    export YOUTUBE_DL_ARGS="--embed-thumbnail --add-metadata -f best"
    alias youtube-dl="youtube-dl $YOUTUBE_DL_ARGS"
    alias youtube-dl-playlist="youtube-dl $YOUTUBE_DL_ARGS -o '~/youtube/%(playlist)s/%(playlist_index)02d - %(title)s.%(ext)s'"
    alias youtube-dl-channel="youtube-dl $YOUTUBE_DL_ARGS -o '~/youtube/%(uploader)s/%(playlist)s/%(upload_date)s - %(title)s.%(ext)s'"
fi
alias rs='rg --fixed-strings'
function rge() { nvim -c "Rg ${*:-}" }
function grge() { nvim -c "GRg ${*:-}" }
function rse() { nvim -c "Rs ${*:-}" }
function grse() { nvim -c "GRs ${*:-}" }

function tmux-cwd() {
    local dir="$1"
    if [ -z "$dir" ]; then
        dir="$PWD"
    fi
    tmux command-prompt "attach -c %1 $dir"
 }

# dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME'

# Start ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# startx if we are running on the 1st tty
if [[ "$(tty)" = "/dev/tty1"  && ! $DISPLAY ]]; then exec startx "$XINITRC"; fi
