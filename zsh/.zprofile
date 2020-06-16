# Set the path
export PATH="$HOME/.node_modules/bin:$HOME/.local/share/cargo/bin:$HOME/.local/share/go/bin:$PATH:$HOME/bin:$HOME/.local/bin"

# Default programs
export BROWSER="firefox"
export EDITOR="nvim"
export READER="zathura"
export PAGER="less"


if (( ${+commands[rustc]} )); then
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi
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
