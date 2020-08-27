# Based on the oh-my-zsh theme gentoo
# (https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/gentoo.zsh-theme)

autoload -U colors && colors # set up the colors arrays
setopt prompt_subst # allow for variable substitution in the prompt

# Print the user and hostname (e.g. user@hostname)
function user_and_hostname {
    # If over ssh, make hostname red. Otherwise, cyan
    if [ -n "$SSH_CLIENT" ] && [ -n "$SSH_TTY" ]; then
        HOSTNAME_COLOR="$fg_bold[red]"
    else
        HOSTNAME_COLOR="$fg_bold[cyan]"
    fi
    # If root, make username red. Otherwise, purple
    echo "%(!.%{$fg_bold[red]%}.%{$fg_bold[magenta]%})%n%{$fg_bold[yellow]%}@%{$HOSTNAME_COLOR%}%m"
}

function filepath {
    # If root, print the full filepath
    # Otherwise print the filepath relative to the user's home directory
    echo "%{$fg_bold[blue]%}%(!.%d.%~)"
}

function git_prompt_info_colored {
    echo "%{$fg_bold[green]%}$(git_prompt_info)"
}

# Print the "prompt character". If root, "#", else "$".
# If the previous command returned nonzero, instead of the prompt character print "✘"
function prompt_char {
    if [ $? -ne 0 ]; then
        echo "%{$fg_bold[red]%}✘"
    elif [ $UID -eq 0 ]; then
        echo "%{$fg_bold[yellow]%}#"
    else
        echo "%{$fg_bold[yellow]%}$"
    fi
}

function make_prompt {
    # Calculate the prompt character first, because it depends on the return value of the previous command
    PROMPT_CHAR=$(prompt_char)
    echo "$(user_and_hostname) $(filepath) $(git_prompt_info_colored)%_$PROMPT_CHAR"
}

# Check comment for 'make_prompt' to see why I did this this way
PROMPT='$(make_prompt)%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="{"
ZSH_THEME_GIT_PROMPT_SUFFIX="} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[red]%}*%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
