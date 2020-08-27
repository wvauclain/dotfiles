# Script to install a pkgbuild from /opt/pkgbuilds
AddPKGBUILD() {
    IgnorePackage --foreign "$1"
    pacman -Qm "$1" >/dev/null 2>&1 && return 0

    tmpdir="$(mktemp -dt localrepo.XXX)"

    [ -n "$1" ] || printf "\033[31merror:\033[0mmust provide a PKGBUILD to install\n"

    case "$1" in
        http*)
            wget -O "$tmpdir/PKGBUILD" "$1"
            ;;
        *)
            [ -d "/opt/pkgbuilds/$1" ] || printf "\033[31merror:\033[0m'%s' does not exist or is not a file\n" "$1"
            cp "/opt/pkgbuilds/$1/"* "$tmpdir"
            ;;
    esac

    cd "$tmpdir" || exit

    makepkg -si PKGBUILD
}
