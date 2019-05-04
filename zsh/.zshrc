##
# zsh settings
##

# colors
autoload -U colors && colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data


##
# zsh imports
##

# setup functions
for file (~/.zsh/*.zsh); do
  source $file
done

# setup the prompt
setopt prompt_subst # allow for variable substitution in the prompt
source ~/.zsh-theme


##
# keybindings
##

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# use emacs keybindings
bindkey -e

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5C' forward-word

# [Ctrl-LeftArrow] - move backward one word
bindkey '^[[1;5D' backward-word


##
# personal config
##

# aliases
alias ls='ls --color=tty'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias md='mkdir -p'
alias l='ls -lAh'
alias ll='ls -lh'
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

# exports
export PATH="$HOME/.node_modules/bin:$PATH:$HOME/bin:$HOME/.local/bin"
export npm_config_prefix=~/.node_modules
export BROWSER="firefox"

# startx if we are running on the 1st tty
if [[ "$(tty)" = "/dev/tty1"  && ! $DISPLAY ]]; then exec startx; fi
