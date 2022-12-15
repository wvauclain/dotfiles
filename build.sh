#!/bin/sh

set -e

if [ -z "$1" ]; then
    echo "error: need to supply a project to build" >&2
    exit 1
fi

MODULE_DIR="modules/$1"

if ! [ -d "$MODULE_DIR" ]; then
    echo "error: module $1 does not exist" >&2
    exit 1
fi

cd "$MODULE_DIR" || exit 1

stow -t"$HOME" stow


if [ -e packages.brew ]; then
    echo "Installing packages from homebrew..."
    arch -arm64 brew bundle --no-lock --file packages.brew
fi

if [ -x postinstall ]; then
    echo "Executing postinstall..."
    ./postinstall
fi
