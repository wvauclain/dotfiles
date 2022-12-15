##
# zsh settings
##

# ls colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

autoload -Uz compinit
compinit

##
# plugins
##

for file ("$HOME"/.config/zsh/*.zsh); do
    source $file
done

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
    export YOUTUBE_DL_ARGS="--embed-thumbnail --add-metadata"
    export YOUTUBE_ARCHIVE_ARGS="$YOUTUBE_DL_ARGS -f best"
    alias youtube-dl="youtube-dl $YOUTUBE_DL_ARGS"

    alias youtube-dl-audio="youtube-dl $YOUTUBE_DL_ARGS -f mp3"

    export YOUTUBE_ARCHIVE_FILENAME="~/Downloads/%(uploader)s -- %(title)s.%(ext)s"
    alias youtube-archive-audio="youtube-dl $YOUTUBE_DL_ARGS --no-playlist -f 'bestaudio[ext=m4a]' -o '$YOUTUBE_ARCHIVE_FILENAME'"
    alias youtube-archive-video="youtube-dl $YOUTUBE_DL_ARGS --no-playlist -f 'mp4[height<=?480]+bestaudio[ext=m4a]' -o '$YOUTUBE_ARCHIVE_FILENAME'"
    alias youtube-archive-video-hd="youtube-dl $YOUTUBE_DL_ARGS --no-playlist -f 'mp4[height<=?1080]+bestaudio[ext=m4a]' -o '$YOUTUBE_ARCHIVE_FILENAME'"
    alias youtube-archive-video-best="youtube-dl $YOUTUBE_DL_ARGS --no-playlist -f 'mp4+m4a' -o '$YOUTUBE_ARCHIVE_FILENAME'"

    # alias youtube-archive="youtube-dl $YOUTUBE_DL_ARGS -f best -o '~/youtube/%(title)s.%(ext)s'"
    # alias youtube-archive-playlist="youtube-dl $YOUTUBE_DL_ARGS -f best -o '~/youtube/%(playlist)s/%(playlist_index)02d - %(title)s.%(ext)s'"
    # alias youtube-archive-channel="youtube-dl $YOUTUBE_DL_ARGS -o '~/youtube/%(uploader)s/%(playlist)s/%(upload_date)s - %(title)s.%(ext)s'"
fi
alias rs='rg --fixed-strings'
function rge() { nvim -c "Rg ${*:-}" }
function grge() { nvim -c "GRg ${*:-}" }
function rse() { nvim -c "Rs ${*:-}" }
function grse() { nvim -c "GRs ${*:-}" }
alias synccals='vdirsyncer sync'

function tmux-cwd() {
    local dir="$1"
    if [ -z "$dir" ]; then
        dir="$PWD"
    fi
    tmux command-prompt "attach -c %1 $dir"
 }

# # Start ssh-agent
# if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#     ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
# fi
# if [[ ! "$SSH_AUTH_SOCK" ]]; then
#     source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
# fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f "/Users/will/.ghcup/env" ] && source "/Users/will/.ghcup/env" # ghcup-env
