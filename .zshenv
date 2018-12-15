ZDOTDIR="$HOME/.config/zsh"

export MYOS="ARCH"
export PAGER=vless
export TERMINAL=termite

if command -v nvim >/dev/null 2>&1; then
    export MANPAGER=vless
    export VISUAL=nvim
    export PAGER=vless
    export EDITOR=$VISUAL
else
    export MANPAGER=less
    export VISUAL=vim
    export EDITOR=$VISUAL
fi
#### HIDPI stuff ####
# NOTE: it seems that xrdb dpi settings obviates the below
# fonts + screen
#export QT_SCALE_FACTOR=2
# just fonts
#export QT_SCREEN_SCALE_FACTORS=2

#export GDK_SCALE=2

# needed if you're gonna use qt5ct
# export QT_QPA_PLATFORMTHEME=qt5ct

# ~/.config/qt5ct/qt5ct.conf      for Qt5
# ~/.config/Trolltech.conf        for Qt4
# ~/.config/gtk-3.0/settings.ini  for Gtk3
# ~/.gtkrc-2.0                    for Gtk2
####

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export CLICOLOR=1
export BROWSER=google-chrome-stable
export LESS="--ignore-case --RAW-CONTROL-CHARS --LONG-PROMPT --QUIET --jump-target=50 --status-column"
export PYENV_ROOT="$HOME/.pyenv"
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/rg.conf

PATH="$HOME/bin/:$HOME/bin/color:/usr/bin:/usr/local/sbin:/usr/local/bin:/bin:/sbin:$PATH"
PATH="$HOME/go/bin:$HOME/.node/bin/:$HOME/.npm-global/bin/:/usr/bin/core_perl:$PATH"

if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$PATH:$(ruby -rrubygems -e 'puts Gem.user_dir')/bin:"
fi
export PATH


export HISTIGNORE="ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."

# export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export GIT_PROMPT_EXECUTABLE=${GIT_PROMPT_EXECUTABLE:-"python"}
export TMUX_TMPDIR="$XDG_CACHE_HOME"

# export FZF_DEFAULT_OPTS='--color=dark --reverse --ansi --exact'
# export FZF_DEFAULT_COMMAND='\rg --hidden -S --files'
export FZF_DEFAULT_OPTS='--height=90% --multi --cycle --ansi   --exact  --color=16'
export FZF_DEFAULT_COMMAND="locate --regex '.*'"
#export ZLE_REMOVE_SUFFIX_CHARS=" \t\n;&|'"
# export ZLE_REMOVE_SUFFIX_CHARS=\'
# export ZLE_SPACE_SUFFIX_CHARS=$'|&'
ZSH_ACTIVE_COMPLETIONS="$( echo ${(kv)_comps[@]} )"


export LESS_TERMCAP_mb=$(printf "\e[1;31m")
export LESS_TERMCAP_md=$(printf "\e[1;31m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[7;49;93m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[1;32m")

# mmm easy python versioning
#if command -v pyenv 1>/dev/null 2>&1; then
  # eval "$(pyenv init -)"
  # following line is sllllowwww
  #eval "$(pyenv virtualenv-init -)"
#fi

