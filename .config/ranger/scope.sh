#!/bin/sh

set -C -f -u

# ranger supports enhanced previews.  If the option "use_preview_script"
# is set to True and this file exists, this script will be called and its
# output is displayed in ranger.  ANSI color codes are supported.

# Meanings of exit codes:
# code | meaning    | action of ranger
# -----+------------+-------------------------------------------
# 0    | success    | success. display stdout as preview
# 1    | no preview | failure. display no preview at all
# 2    | plain text | display the plain content of the file
# 3    | fix width  | success. Don't reload when width changes
# 4    | fix height | success. Don't reload when height changes
# 5    | fix both   | success. Don't ever reload
# 6    | image      | success. display the image $cached points to as an image preview
# 7    | image      | success. display the file directly as an image

# Meaningful aliases for arguments:
path="$1"            # Full path of the selected file
width="$2"           # Width of the preview pane (number of fitting characters)
height="$3"          # Height of the preview pane (number of fitting characters)
cached="$4"          # Path that should be used to cache image previews
preview_images="$5"  # "True" if image previews are enabled, "False" otherwise.

# Set IFS to a newline in a POSIX-compliant way
IFS="$(printf '%b_' '\n')"
IFS="${IFS%_}"

header() {
    printf "\033[32m%s\033[0m\n\n" "$*"
}

error() {
    printf "\033[31m%s\033[0m\n" "$*"
}

fail_if_large() {
    # If the file is at least 256KiB, don't try to render it
    if [ "$( stat --printf='%s' -- "${path}")"  -ge "262144" ]; then
        error "File ${path} too large to display"
        exit 1
    fi
}

preview_text() {
    bat --line-range ":${height}" -p --color always "$@"
}

handle_mime() {
    case "$1" in
        text/troff)
            header "Contents of ${path}:"
            fail_if_large
            man ./ "${path}" | col -bx | preview_text --language man
            ;;

        text/* | */xml)
            header "Contents of ${path}:"
            fail_if_large
            preview_text -- "${path}"
            ;;

        application/json)
            header "Contents of ${path}:"
            fail_if_large
            jq --color-output . "${path}"
            ;;

        # Render INI files using TOML syntax highlighting since bat understands TOML
        application/x-wine-extension-ini)
            header "Contents of ${path}:"
            preview_text --language toml -- "${path}"
            ;;

        application/zip | application/gzip | application/zstd | application/x-tar)
            header "Contents of ${path}:"
            bsdtar --list --file "${path}"
            ;;

        image/*)
            if [ "$preview_images" = "True" ]; then
                exit 7
                # # Rotate the image if necessary
                # orientation="$( identify -format '%[EXIF:Orientation]\n' -- "${path}")"
                # # If orientation data is present and the image actually
                # # needs rotating ("1" means no rotation)...
                # if [ -n "$orientation" ] &&  [ "$orientation" != 1 ]; then
                #     # ...auto-rotate the image according to the EXIF data.
                #     convert -- "${path}" -auto-orient "${cached}" && exit 6 || error "Couldn't convert the image"
                # else
                #     exit 7
                # fi
            fi

            header "Info for ${path}:"
            mediainfo "${path}"
            ;;

        video/*)
            if [ "$preview_images" = "True" ]; then
                ffmpeg -i "file:${path}" -ss 00:00:01.000 -vframes 1 "${cached}" 2>&1 && exit 6 || error "Couldn't grab thumbnail for ${path}"
            fi

            header "Info for ${path}:"
            mediainfo "${path}"
            ;;

        audio/*)
            header "Info for ${path}:"
            mediainfo "${path}"
            ;;

        */pdf)
            if [ "$preview_images" = "True" ]; then
                pdftoppm -jpeg -singlefile "$path" "${cached//.jpg}" && exit 6 || error "Couldn't convert first page to image"
            fi

            text=$(pdftotext -l 10 -nopgbrk -q -- "${path}" -)
            if [ -z "$text" ]; then
                header "Info for ${path}:"
                pdfinfo "${path}"
            else
                header "${path}:"
                echo "$text"
            fi
            ;;

        inode/directory)
            header "Contents of ${path}:"
            ls -1 "${path}"
            ;;

        *)
            error "Unable to preview mime type $1. Printing generic info:"
            file --dereference "${path}" | fold -s
            echo
            stat "${path}"
            ;;
    esac
}

handle_mime "$(file --dereference --brief --mime-type -- "${path}")"
