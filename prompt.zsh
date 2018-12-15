#!/usr/bin/env zsh

####### NEW #### {{{

# https://joshdick.net/2017/06/08/my_git_prompt_for_zsh_revisited.html
__git_info() {


    # Git branch/tag, or name-rev if on detached head
    #local GIT_LOCATION=${$((git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null)#(refs/heads/|tags/)}
    local GIT_LOCATION="$(git branch 2>/dev/null | grep '*' | awk '{ print $2 }')"


    if [ -n "$GIT_LOCATION" ]; then

        local AHEAD="%F{red}⇡NUM%f"
        local BEHIND="%F{cyan}⇣NUM%f"
        #local MERGING="%F{magenta}︎%f"
        local MERGING="%F{magenta}8%f"
        local UNTRACKED="%F{red}●%f"
        local MODIFIED="%F{yellow}●%f"
        local STAGED="%F{green}●%f"

        local -a DIVERGENCES
        local -a FLAGS

        local NUM_AHEAD="$(git log --oneline @\{u\}.. 2> /dev/null | wc -l | tr -d ' ')"
        if [ "$NUM_AHEAD" -gt 0 ]; then
            DIVERGENCES+=( "${AHEAD//NUM/$NUM_AHEAD}" )
        fi

        local NUM_BEHIND="$(git log --oneline ..@\{u\} 2> /dev/null | wc -l | tr -d ' ')"
        if [ "$NUM_BEHIND" -gt 0 ]; then
            DIVERGENCES+=( "${BEHIND//NUM/$NUM_BEHIND}" )
        fi

        local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
        if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
            FLAGS+=( "$MERGING" )
        fi

        if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
            FLAGS+=( "$UNTRACKED" )
        fi

        if ! git diff --quiet 2> /dev/null; then
            FLAGS+=( "$MODIFIED" )
        fi

        if ! git diff --cached --quiet 2> /dev/null; then
            FLAGS+=( "$STAGED" )
        fi

        local -a GIT_INFO
        #GIT_INFO+=( "%F{12}%f" )
        #GIT_INFO+=( "%F{12}G%f" )
        [ -n "$GIT_STATUS" ] && GIT_INFO+=( "$GIT_STATUS" )
        [[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)DIVERGENCES}" )
        [[ ${#FLAGS[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)FLAGS}" )
        echo "${(j: :)GIT_INFO} %F{12}[%f%F{blue}$GIT_LOCATION%f%F{12}]%f"

    fi


}

__set_title() {
    printf '\e]1;%s\a' $(hostname)
}

### }}}

##### CURRENT {{{

## mix and match! docs/kewlunicode.txt for more
##  ☆ ☆  ➤   ➔   ➜   λ   ➜   ❯ ᛋ ϟ  ►
fun1='λ'
#fun2='⟩'
#fun2='⯈'
#fun2='►'
#fun2='❯'
#fun2='►'
fun2='>'

check_last_exit_code() {
    local LAST_EXIT_CODE=$?
    if [[ $LAST_EXIT_CODE -ne 0 ]]; then
        local EXIT_CODE_PROMPT=' '
        EXIT_CODE_PROMPT+="%F{red}-%f"
        EXIT_CODE_PROMPT+="%F{red}%B$LAST_EXIT_CODE%b%f"
        EXIT_CODE_PROMPT+="%F{red}-%f"
        echo "$EXIT_CODE_PROMPT"
    fi
}

if [[ -z "$SSH_CLIENT" ]]; then
    prompt_host="%F{4}%n@%f%F{4}%m%f "
else
    prompt_host="%F{12}%n@%f%F{1}%m%f "
fi

## coolx='\033[38;5;160mϟ\033[0m'
PROMPT="$(__set_title)$prompt_newline${prompt_host} $prompt_newline%(?.%F{yellow}.%F{red})${fun1}%f%F{green}%(1j. [%j].)%f%F{10} %~ %f%F{blue}${fun2}%f "
PROMPT_TIME='%F{12}[%f%F{blue}%T%f%F{12}]%f'

# if [ -n "$LIGHT_PROMPT" ]; then
#     RPROMPT='$PROMPT_TIME'
# else
#     RPROMPT='$(__git_info) $PROMPT_TIME'
# fi

# prompt.lite() {
#     export RPROMPT='$PROMPT_TIME'
# }


# prompt.full() {
#     export RPROMPT='$(__git_info) $PROMPT_TIME'
# }


RPROMPT='$(__git_info) $PROMPT_TIME'


