#!/bin/sh

# Exit on error
set -e

install_configuration() {
    stow -R -t ~ $1

    if [ -e "$1-postinstall.sh" ]; then
        sh "$1-postinstall.sh"
    fi
}

while [ -n "$1" ]; do
    if [ -d "$1" ]; then
        install_configuration "$1"
    elif [ -f "$1" ]; then
        while read -r line; do
            [ -n "$line" ] && install_configuration "$line"
        done < "$1"
    fi

    shift
done

exit 0
