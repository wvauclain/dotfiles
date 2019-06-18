#!/bin/sh

usage() {
    cat <<EOF
Usage: ./install.sh [-v|--verbose] OPTION
Options:
  -b, --bootstrap               Install everything required to install configs
  -f, --from-file [FILE]        Install all of the configs specified in FILE.
                                Defaults to installing HOSTNAME.conf
  -h, --help                    Print this help message
  -i, --install <CONFIG>        Install CONFIG
EOF
}

if [ "$1" = "-v" ] || [ "$1" = "--verbose" ]; then
    VERBOSE=true
    shift
fi

case $1 in
    -b|--bootstrap)
        BOOTSTRAP=true
        ;;
    -f|--from-file)
        if [ -e "$2" ]; then
            FILE="$2"
        elif [ -z "$2" ]; then
            FILE="$(hostname).conf"
        else
            echo "Error: File $2 does not exist"
            exit 1
        fi
        ;;
    -i|--install)
        if [ -n "$2" ]; then
            CONFIG="$2"
        else
            echo "Error: Configuration name required"
        fi
        ;;
    -h|--help)
        usage
        exit 0
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

distro() {
    if [ `uname -o` = "Android" ]; then
        echo "Termux"
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
            distro_install base-devel git unzip wget jq

            git clone https://aur.archlinux.org/trizen.git
            cd trizen
            makepkg -si
            ;;
        "Debian"|"Ubuntu")
            distro_install build-essential git unzip wget jq
            ;;
        *)
            echo "$DISTRO is currently not supported for bootstrapping"
            ;;
    esac

    # Install Rust
    [ -e ~/.cargo/env ] && . ~/.cargo/env
    which rustup > /dev/null ||\
        (curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup.sh\
             && sh rustup.sh -y)
    . ~/.cargo/env
    rustup toolchain list | grep nightly > /dev/null || rustup toolchain add nightly
    rustup component list | grep rust-src > /dev/null || rustup component add rust-src
    which racer > /dev/null || cargo +nightly install racer

    # Install wspm
    if ! [ -e ~/.wspm/bin/wspm ]; then
        wget --tries=10 https://github.com/wvauclain/wspm/archive/master.zip
        unzip master.zip
        rm master.zip
        cd wspm-master
        cargo run --release -- --noconfirm install .
        cd ..
    fi

    # Install wsdm
    if ! [ -e ~/.wspm/bin/wsdm ]; then
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
        *)
            printf "none"
            ;;
    esac
}

post_install_configuration() {
    . ~/.cargo/env

    # Install required programs from package manager
    PROGRAMS=$([ -e "$1-requirements.json" ] && cat "$1-requirements.json"\
                       | jq ".$(package_manager_str)" 2> /dev/null\
                       | tr -d "[\",]" | awk 'NF' | sed -e 's/^[ \t]*//'\
                       | tr '\n' ' ')
    [ -n "$PROGRAMS" ] && distro_install $PROGRAMS

    [ -e "$1-postinstall.sh" ] && sh "$1-postinstall.sh" "$(package_manager_str)"
}

if [ $BOOTSTRAP ]; then
    bootstrap
elif [ -n "$FILE" ]; then
    # Install all the configs in the given file
    if [ -e "$FILE" ]; then
        while read -r line; do
            [ "$VERBOSE" ] && echo "Installing $line..."
            [ -d "$line" ] && ~/.wspm/bin/wsdm --noconfirm install "$line"
            post_install_configuration "$line"
        done < $FILE
    else
        echo "Error: $FILE not found"
    fi
else
    # Install the given config
    if [ -d "$CONFIG" ]; then
        ~/.wspm/bin/wsdm install "$CONFIG"
    fi
    post_install_configuration "$CONFIG"
fi

exit 0