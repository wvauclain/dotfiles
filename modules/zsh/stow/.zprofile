eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$HOME/.cargo/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH:$HOME/.local/bin"
export PATH="/opt/homebrew/opt/llvm@12/bin:$PATH"
# Setting PATH for Python 3.9
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:${PATH}"
export PATH

export GOPATH="/Users/$USER/go"
export PATH="$GOPATH/bin:$PATH"

export EDITOR=nvim
alias view=nvim

export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"
