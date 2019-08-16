#!/bin/sh

# Exit on error
set -e

usage() {
    cat <<EOF
Usage: ./install.sh [OPTION(s)] COMMAND
Options:
  -h, --help                    Print this help message
  -v, --verbose                 Increase the verbosity of error messages
  -u, --update                  Install the newest version of a dependency,
                                even if the dependency is already installed
  -s, --stow                    Use stow instead of wsdm
Commands:
  b, bootstrap                  Install everything required to install configs
  f, from-file [FILE]           Install all of the configs specified in FILE.
  i, install <CONFIG>           Install CONFIG
EOF
}

while [ "$1" ]; do
    case $1 in
        # Options
        -h|--help)
            usage
            exit 0
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -u|--update)
            UPDATE=true
            shift
            ;;
        -s|--stow)
            STOW=true
            shift
            ;;
        # Commands
        b|bootstrap)
            BOOTSTRAP=true
            shift
            ;;
        f|from-file)
            shift
            if [ -e "$1" ]; then
                FILE="$1"
                shift
            elif [ -z "$1" ]; then
                FILE="$(hostname).conf"
            else
                echo "Error: File $1 does not exist"
                exit 1
            fi
            ;;
        i|install)
            shift
            if [ -n "$1" ]; then
                CONFIG="$1"
                shift
            else
                echo "Error: Configuration name required"
            fi
            ;;
        "")
            echo "Error: Option required"
            echo
            usage
            exit 1
            ;;
        *)
            echo "Error: Unrecognized option $1"
            echo
            usage
            exit 1
            ;;
    esac
done

if [ -z "$UPDATE" ]; then
    UPDATE=false
fi

if [ -z "$STOW" ]; then
    STOW=false
fi

distro() {
    if [ `uname -o` = "Android" ]; then
        echo "Termux"
    elif which pacman > /dev/null; then
        echo "Arch Linux"
    elif which xbps-install > /dev/null; then
        echo "Void Linux"
    elif [ `uname` = "Linux" ]; then
        cat /etc/*-release | grep ^NAME | awk -F '=' '{ print $2 }' | tr -d '"'
    elif [ `uname` == 'Darwin' ]; then # macOS
        echo "macOS"
    fi
}

distro_install() {
    DISTRO=$(distro)
    case $DISTRO in
        "Arch Linux")
            sudo pacman -Syu --noconfirm --needed --quiet $@
            ;;
        "Debian"|"Ubuntu")
            sudo apt-get update
            sudo apt-get install --assume-yes $@
            ;;
        "Void Linux")
            sudo xbps-install -Syu $@
            ;;
        "Termux")
            pkg install $@
            ;;
        *)
            echo "$DISTRO is currently not supported"
            ;;
    esac
}


bootstrap() {
    # Create temporary directory
    [ -e tmp ] && rm -rf tmp
    mkdir -p tmp
    cd tmp

    # Install required programs for base installation
    DISTRO=$(distro)
    case $DISTRO in
        "Arch Linux")
            distro_install base-devel git unzip wget jq curl

            if ( ! which trizen > /dev/null || $UPDATE ); then
                git clone https://aur.archlinux.org/trizen.git
                cd trizen
                makepkg -si --noconfirm
            fi
            ;;
        "Void Linux")
            distro_install base-devel git unzip wget jq curl
            ;;
        "Debian"|"Ubuntu"|"Termux")
            distro_install build-essential git unzip wget jq curl
            ;;
        *)
            echo "$DISTRO is currently not supported for bootstrapping"
            exit 1
            ;;
    esac

    # Install Rust
    [ -e ~/.cargo/env ] && . ~/.cargo/env
    ( which rustup > /dev/null && ! $UPDATE ) ||\
        (curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup.sh\
             && sh rustup.sh -y --no-modify-path)
    . ~/.cargo/env
    rustup toolchain list | grep nightly > /dev/null || rustup toolchain add nightly
    rustup component list | grep rust-src > /dev/null || rustup component add rust-src
    $UPDATE && rustup update
    ( which racer > /dev/null && ! $UPDATE ) || \
	cargo +nightly install racer $($UPDATE && echo "--force")


    # Install wspm
    if ( ! [ -e ~/.wspm/bin/wspm ] || $UPDATE ) ; then
        wget --tries=10 https://github.com/wvauclain/wspm/archive/master.zip
        unzip master.zip
        rm master.zip
        cd wspm-master
        cargo run --release -- --noconfirm install .
        cd ..
    fi

    # Install wsdm
    if ( ! [ -e ~/.wspm/bin/wsdm ] || $UPDATE ); then
        wget --tries=10 https://github.com/wvauclain/wsdm/archive/master.zip
        unzip master.zip
        rm master.zip
        ls
        cd wsdm-master
        ~/.wspm/bin/wspm --noconfirm install .
        cd ..
    fi

    cd ..

    rm -rf tmp
}

package_manager_str() {
    DISTRO=$(distro)
    case $DISTRO in
        "Arch Linux")
            printf "pacman"
            ;;
        "Debian"|"Ubuntu")
            printf "apt"
            ;;
        "Termux")
            printf "termux"
            ;;
        "Void Linux")
            printf "xbps"
            ;;
        *)
            printf "none"
            ;;
    esac
}

install_configuration() {
    if $STOW; then
        stow -R $@
    else
        ~/.wspm/bin/wsdm --noconfirm install $@
    fi
}

post_install_configuration() {
    [ -e ~/.cargo/env ] && . ~/.cargo/env

    # Install required programs from package manager
    PROGRAMS=$([ -e "$1-requirements.json" ] && cat "$1-requirements.json"\
                       | jq ".$(package_manager_str)" 2> /dev/null\
                       | tr -d "[\",]" | awk 'NF' | sed -e 's/^[ \t]*//'\
                       | tr '\n' ' ' || true)

    [ -n "$PROGRAMS" ] && [ "$PROGRAMS" != "null " ] && distro_install $PROGRAMS || true


    ! $STOW && [ -e "$1-postinstall.sh" ] && \
	UPDATE=$UPDATE sh "$1-postinstall.sh" "$(package_manager_str)" || true
}

if [ $BOOTSTRAP ]; then
    bootstrap
elif [ -n "$FILE" ]; then
    # Install all the configs in the given file
    if [ -e "$FILE" ]; then
        while read -r line; do
            [ "$VERBOSE" ] && echo "Installing $line..."
            [ -d "$line" ] && install_configuration "$line"
            post_install_configuration "$line"
        done < $FILE
    else
        echo "Error: $FILE not found"
    fi
else
    # Install the given config
    if [ -d "$CONFIG" ]; then
        install_configuration "$CONFIG"
    fi
    post_install_configuration "$CONFIG"
fi

exit 0
