# Set the path
export PATH="$HOME/.local/share/cargo/bin:$HOME/.local/share/go/bin:$HOME/.config/bin:$HOME/.local/bin:$PATH"

# Default programs
export BROWSER="firefox"
export EDITOR="nvim"
export READER="zathura"
export PAGER="less"


export DOTFILES="$HOME/.local/share/dotfiles"

# Clean up home directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
export LESSHISTFILE="-"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export DVDCSS_CACHE="$XDG_DATA_HOME"/dvdcss
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export LESSHISTFILE=/dev/null
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

if (( ${+commands[rustc]} )); then
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

# FZF config
export FZF_DEFAULT_COMMAND="fd ."
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND $HOME"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export FZF_DEFAULT_OPTS='--exact'

# Only use my rc.conf for ranger
export RANGER_LOAD_DEFAULT_RC=false
