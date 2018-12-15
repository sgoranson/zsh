#!env zsh

# ZOPTIONS {{{
HISTSIZE=10000000
SAVEHIST=999999
# HISTCONTROL=ignoredups

if [ -z $HISTFILE ]; then
    HISTFILE=$XDG_CACHE_HOME/.zsh_history
fi

autoload -U colors
colors
zmodload zsh/zpty


## History command configuration
setopt EXTENDED_HISTORY       # record timestamp of command in HISTFILE
setopt HIST_EXPIRE_DUPS_FIRST # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_IGNORE_DUPS       # ignore duplicated commands history list
setopt HIST_IGNORE_SPACE      # ignore commands that start with space
setopt NO_HIST_VERIFY            # show command with history expansion to user before running it
setopt INC_APPEND_HISTORY     # add commands to HISTFILE in order of execution
setopt SHARE_HISTORY          # share command history data




setopt   NOBEEP
setopt   NOCORRECTALL
setopt NO_HUP

setopt   IGNORE_EOF
setopt   AUTOCD
setopt   AUTOPUSHD
setopt   PUSHD_IGNORE_DUPS
setopt   PUSHDMINUS
setopt   PUSHDSILENT
setopt   PUSHDTOHOME
setopt   CDABLEVARS
setopt   EXTENDEDGLOB
unsetopt NOMATCH
unsetopt PRINT_EXIT_VALUE

setopt   PROMPTSUBST       # Allow for functions in the prompt.
setopt   PROMPTPERCENT

setopt   LONG_LIST_JOBS
setopt   MARK_DIRS         # Add "/" if completes directory
setopt   MAGIC_EQUAL_SUBST # Enable completion in "--option=arg"
setopt   NO_MENU_COMPLETE   # DO NOT AUTOSELECT THE FIRST COMPLETION ENTRY
setopt   NOFLOWCONTROL
setopt   AUTO_MENU         # SHOW COMPLETION MENU ON SUCCESIVE TAB PRESS
setopt   COMPLETE_IN_WORD
setopt   ALWAYS_TO_END
setopt   COMPLETEALIASES
setopt   AUTO_REMOVE_SLASH
# }}}

# LOAD RC's {{{
fpath=($ZDOTDIR/completion $fpath)

zmodload -i zsh/complist  # for menucomplete

# Save the location of the current completion dump file.
if [ -z "$ZSH_COMPDUMP" ]; then
    SHORT_HOST=${HOST/.*/}
    ZSH_COMPDUMP="${XDG_CACHE_HOME}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
fi


autoload -U compinit
compinit -u -d "${ZSH_COMPDUMP}"


autoload -U promptinit && promptinit
autoload -U +X bashcompinit && bashcompinit


autoload -U zcalc

eval "$(dircolors "$XDG_CONFIG_HOME"/dircolors)"

source $ZDOTDIR/prompt.zsh
source $ZDOTDIR/zsh-history-substring-search.zsh
# source $ZDOTDIR/fzf-fasd.plugin.zsh
# source $ZDOTDIR/zsh-interactive-cd.plugin.zsh
source $ZDOTDIR/keys.zsh
source $ZDOTDIR/clipboard.zsh
source $ZDOTDIR/completion.zsh
source $ZDOTDIR/git-extras-completion.zsh
source $ZDOTDIR/s_completion.sh
source $ZDOTDIR/fzf-marks.plugin.zsh
source $ZDOTDIR/i3_completion.sh
#source $ZDOTDIR/zsh-better-npm-completion.plugin.zsh
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/completion/git-extra
source $ZDOTDIR/extract.plugin.zsh
# source $HOME/bin/z.sh
source $ZDOTDIR/zsh-autosuggestions.zsh

# }}}

# zcalc {{{
autoload -U zcalc
function __calc_plugin {
    zcalc -e "$*"
}
aliases[calc]='noglob __calc_plugin'
aliases[=]='noglob __calc_plugin'
# }}}


# DIRECTORY HISTORY {{{

DIRSTACKSIZE=20
DIRSTACKFILE=$XDG_CACHE_HOME/.zdirs
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
  ls
}


if [[ -z "$ZSH_CDR_DIR" ]]; then
    ZSH_CDR_DIR=${XDG_CACHE_HOME:-$HOME/.cache}/zsh-cdr
fi
mkdir -p $ZSH_CDR_DIR
autoload -Uz chpwd_recent_dirs cdr
autoload -U add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-file $ZSH_CDR_DIR/recent-dirs
zstyle ':chpwd:*' recent-dirs-max 90
# fall through to cd
zstyle ':chpwd:*' recent-dirs-default yes



# }}}

# ETC {{{
umask 022

# get a prompt if ppl be loggin

# watch=all                       # watch all logins
# logcheck=30                     # every 30 seconds
# WATCHFMT="%n from %M has %a tty%l at %T %W"


case $TERM in
    xterm*)
        precmd () {
            if [ -n "$SSH_CLIENT" ]; then
            print -Pn "\e]0;%n@%m: %~ %x\a"
        else
            print -Pn "\e]0;%n: %~ %x\a"
        fi
        }
        ;;
esac

if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

# silly bash.org msg
# ruby -e 'require "open-uri"; puts open("http://bash.org/?random").read.match(/"qt">(.*?)<\/p/m)[1].gsub(/(&.*?;|<.*?\/>)/, "")'

#source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Disable flow control (ctrl+s, ctrl+q) to enable saving with ctrl+s in Vim
stty -ixon -ixoff
# }}}



if [ -f "$HOME/.zshmine" ]; then
    . "$HOME/.zshmine"
fi

export DISPLAY=:0

# BANNER {{{


# cat ~/bin/ansi/esc.txt
cat ~/bin/ansi/cat.txt

sgbanner

# }}}


# vim:fdm=marker:
