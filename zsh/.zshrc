# User configuration
export PATH="$HOME/.node_modules/bin:$PATH:$HOME/bin:$HOME/.local/bin"
export npm_config_prefix=~/.node_modules

#Oh My Zsh configuration
ZSH_THEME="goldenarches" # My custom theme

plugins=(
  git
  archlinux
)

export ZSH="/home/will/.oh-my-zsh"
export ZSH_CUSTOM="/home/will/.oh-my-zsh-custom"
source $ZSH/oh-my-zsh.sh

export BROWSER="firefox --new-tab"

if [[ "$(tty)" = "/dev/tty1"  && ! $DISPLAY ]]; then exec startx; fi
