# Based on the oh-my-zsh theme gentoo
# (https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/gentoo.zsh-theme)

# Outputs current branch info in prompt format
function git_prompt_info() {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
      ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0

  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Checks if working tree is dirty
function parse_git_dirty() {
  local STATUS
  STATUS=$(command git status --porcelain --ignore-submodules=dirty | tail -n1)

  if [[ -n $STATUS ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

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
# If the previous command returned nonzero, instead of the prompt character print the exit code and "✘"
PROMPT_CHAR="%(?.%{$fg_bold[yellow]%}%(!.#.$).%{$fg_bold[red]%}<%?> ✘)"

function make_prompt {
    local prompt_str="$(user_and_hostname) $(filepath) $(git_prompt_info_colored)"
    # https://stackoverflow.com/questions/10564314/count-length-of-user-visible-string-for-zsh-prompt
    local zero='%([BSUbfksu]|([FK]|){*})'
    local prompt_length=${#${(S%%)prompt_str//$~zero/}}
    if [ $(($(tput cols) - $prompt_length)) -gt 40 ]; then
      echo "$prompt_str%_$PROMPT_CHAR"
    else
      echo "$prompt_str"
      echo " $PROMPT_CHAR"
    fi
}

# Check comment for 'make_prompt' to see why I did this this way
PROMPT='$(make_prompt)%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="{"
ZSH_THEME_GIT_PROMPT_SUFFIX="} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[red]%}*%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
