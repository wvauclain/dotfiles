# Expand aliases using control-space

globalias() {
    # If the buffer just has a command name with possible leading and trailing whitespace
    if [[ $LBUFFER =~ [[:space:]]*[a-zA-Z0-9_-]+[[:space:]]*$ ]]; then
        # Trim trailing whitespace
        LBUFFER="$(echo "$LBUFFER" | sed 's/\s*$//')"
        # Expand aliases and words
        zle _expand_alias
        zle expand-word
        # Add back a trailing space
        LBUFFER+=' '
    fi
}

zle -N globalias

bindkey "^ " globalias
