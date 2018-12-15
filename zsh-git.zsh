# see documentation at http://linux.die.net/man/1/zshexpn
# A: finds the absolute path, even if this is symlinked
# h: equivalent to dirname
# export __GIT_PROMPT_DIR=${0:A:h}

autoload -U add-zsh-hook

add-zsh-hook chpwd chpwd_update_git_vars
add-zsh-hook preexec preexec_update_git_vars
add-zsh-hook precmd precmd_update_git_vars

## Function definitions
function preexec_update_git_vars() {
    case "$2" in
        git*|hub*|gh*|stg*)
        __EXECUTED_GIT_COMMAND=1
        ;;
    esac
}

function precmd_update_git_vars() {
    if [ -n "$__EXECUTED_GIT_COMMAND" ]; then
        update_current_git_vars
        unset __EXECUTED_GIT_COMMAND
    fi
}

function chpwd_update_git_vars() {
    update_current_git_vars
}

function update_current_git_vars() {
    unset __CURRENT_GIT_STATUS

    _GIT_STATUS=`gitstatus.py 2>/dev/null`
    __CURRENT_GIT_STATUS=("${(@s: :)_GIT_STATUS}")

    GIT_BRANCH=$__CURRENT_GIT_STATUS[1]
    GIT_AHEAD=$__CURRENT_GIT_STATUS[2]
    GIT_BEHIND=$__CURRENT_GIT_STATUS[3]
    GIT_STAGED=$__CURRENT_GIT_STATUS[4]
    GIT_CONFLICTS=$__CURRENT_GIT_STATUS[5]
    GIT_CHANGED=$__CURRENT_GIT_STATUS[6]
    GIT_UNTRACKED=$__CURRENT_GIT_STATUS[7]
}


git_super_status() {
    precmd_update_git_vars
    if [ -n "$__CURRENT_GIT_STATUS" ]; then
      # STATUS="$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_BRANCH $GIT_BRANCH %{${reset_color}%}"
      STATUS="%F{blue} [%f%F{12}${GIT_BRANCH}%f%F{blue}] (%f"
      if [ "$GIT_BEHIND" -ne "0" ]; then
          STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_BEHIND$GIT_BEHIND%F{12}|%f"
      fi
      if [ "$GIT_AHEAD" -ne "0" ]; then
          STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD$GIT_AHEAD%f%F{12}|%f"
      fi
      if [ "$GIT_STAGED" -ne "0" ]; then
          STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED$GIT_STAGED"
      fi
      if [ "$GIT_CONFLICTS" -ne "0" ]; then
          STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CONFLICTS$GIT_CONFLICTS"
      fi
      if [ "$GIT_CHANGED" -ne "0" ]; then
          STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CHANGED$GIT_CHANGED"
      fi
      if [ "$GIT_UNTRACKED" -ne "0" ]; then
          STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
      fi
      if [ "$GIT_CHANGED" -eq "0" ] && [ "$GIT_CONFLICTS" -eq "0" ] && [ "$GIT_STAGED" -eq "0" ] && [ "$GIT_UNTRACKED" -eq "0" ]; then
          STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CLEAN"
      fi
      echo "$STATUS)"
    fi
}

# Default values for the appearance of the prompt. Configure at will.
# ZSH_THEME_GIT_PROMPT_STAGED='%F{5} ● %G%f '
# ZSH_THEME_GIT_PROMPT_CONFLICTS='%F{red}  ✖ %G%f '
# ZSH_THEME_GIT_PROMPT_CHANGED='%F{yellow} ✚ %G%f '
# ZSH_THEME_GIT_PROMPT_BEHIND='F{yellow} ↓ %G%f '
# ZSH_THEME_GIT_PROMPT_AHEAD='%F{green} ↑ %G%f '
# ZSH_THEME_GIT_PROMPT_UNTRACKED='%F{green}… %G%f '
# ZSH_THEME_GIT_PROMPT_CLEAN='%F{8}✔ %G%f '

#ZSH_THEME_GIT_PROMPT_STAGED="%{%F{5} %G%f%} "
#ZSH_THEME_GIT_PROMPT_CHANGED="%{%F{yellow} %}%{%G%f%} "
#ZSH_THEME_GIT_PROMPT_CONFLICTS='%F{red}  ✖ %G%f '
# ZSH_THEME_GIT_PROMPT_BEHIND='F{yellow} ↓ %G%f '
# ZSH_THEME_GIT_PROMPT_AHEAD='%F{green} ↑ %G%f '
#ZSH_THEME_GIT_PROMPT_UNTRACKED='%{%F{green}… %}%{%G%f %}'
# ZSH_THEME_GIT_PROMPT_CLEAN='%F{8}✔ %G%f '



ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[red]%}⇡%G%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[cyan]%}⇣%G%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[magenta]%}︎\!%G%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}●%G%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[yellow]%}●%G%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}●%G%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN='%F{8}✔ %G%f '
