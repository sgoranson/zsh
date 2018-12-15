# reset them all
unalias -m '*'

# SUFFIX HANDLERS {{{
alias -s txt=nvim
alias -s md=nvim
alias -s mp4='mpv --loop'
alias -s webm='mpv --loop'
alias -s gif='mpv --loop'
alias -s jpg='mpv --loop'
alias -s jpeg='mpv --loop'
alias -s png='mpv --loop'
# }}}


# directories
#hash -d dot="~/dotfiles"
#hash -d tmp="$XDG_CACHE_HOME"

hash -d -- dot=/home/steve/dotfiles
hash -d -- src=/home/steve/src

# GLOBAL {{{1
alias open="/mnt/c/Windows/System32/cmd.exe /c start"
alias start="/mnt/c/Windows/System32/cmd.exe /c start"

alias nvd='nvim $(git -C ~/dotfiles ls-files | fzf --height=40% --reverse --ansi   --exact  --color=16)'
alias r=ranger
alias RM=trash
alias CM='chmod a+x'
alias AX='chmod a+x'
alias w='which'
alias pb=pastebin
alias goo=google-chrome-stable
alias web=google-chrome-stable
alias chrome-lodpi='GDK_DPI_SCALE=0.5 google-chrome-stable'

alias ls="\ls -A --file-type --color=auto"
alias ll="ls -lhAtr --file-type --color=auto"
alias pu="pushd"
alias po="popd"
alias fff="find . -iname '*"
alias ff='find . -type f'
# alias ff="\rg --color=auto --hidden --files"
alias gs="git status"
alias v="vless"

alias pss='ps axo pid,ppid,stat,args --sort=start_time'
alias psl='ps wwaxo pid,ppid,stat,args --sort=start_time'

# cron dont like backupfiles
alias crontab="VIM_CRONTAB=true crontab"
alias cp="cp -i"
alias rm="rm -i"
alias mv="mv -i"
alias tmux="TERM=xterm-256color \tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias vim=nvim
alias grep='grep --color=auto'
# -b ignore blanks -B ignore newlines
alias diff="diff -ybB"

alias 16=xterm_16.sh
alias 256=xterm_256.sh

if command -v cdu >/dev/null 2>&1; then
    # -i smart colors, -s sort by size, -R recurse, -dh human readable
    alias cdu="cdu -i -sR -dh"
    alias du="cdu -i -sR -dh"
fi

if command -v dfc >/dev/null 2>&1; then
    alias df=dfc
fi

alias a1="awk '{ print \$1}'"
alias a2="awk '{ print \$2}'"
alias a3="awk '{ print \$3}'"
alias a4="awk '{ print \$4}'"
alias a5="awk '{ print \$5}'"

alias -g G=' | grep -i'
alias -g H=' | head'
alias -g Hl=' --help |& less -r'
alias -g C=' | xclip -r -selection clipboard -i'

alias PI="pip install --user --upgrade"
alias PS="pip search"
alias PL="pip list"

NI() {
    sudo npm -g install  ${1:?}
    if [ $? -eq 0 ]; then
        if ! grep -Eq "^${1}$" "$HOME/dotfiles/install/pkg-lists/npm.txt" ; then
            echo $1 >> "$HOME/dotfiles/install/pkg-lists/npm.txt"
        fi
    fi
}

alias NR="npm -g uninstall"
alias NS="npm search -l"
alias NL="npm list -g --depth=0 2>/dev/null"

alias GI="gem install --user-install"
alias GLL="gem list --local"
alias GL="gem contents"

alias SGG='echo tert.havkwhaxvr@arg | tr a-z@. n-za-m.@'

# dir shortcuts
alias ddot="pu ~/dotfiles"

mkd() { mkdir -p ${1:?} && cd $1 }
a() { awk "{ print \$${1:-0} }" } # shortcut for awk '/ print $1/'
hh() { $1 --help | vless }
hex2dec() { perl -e "print hex $1" }
dec2hex() { printf "%x\n" $1 }

# no file --no-heading, search --hidden, -uu ignore nvc ignores, follow syms -f, smartcase -S
if command -v rg >/dev/null 2>&1; then
    alias rgg="\rg --no-heading --no-filename --no-line-number --hidden"
    alias rg="\rg --no-heading --hidden"
    alias rgf="\rg --hidden --files"
fi

# cheat sheets
alias cheatsh='curl cheat.sh'

if command -v ccat >/dev/null 2>&1; then
    alias -g L=' | ccat | vless'
else
    alias -g L=' | vless'
fi

alias pkg-config="pkg-config  --keep-system-libs  --keep-system-cflags"

# no file --noheading, search --hidden, -U ignore nvc ignores, follow syms -f, smartcase -S
#alias ag='ag --noheading --hidden -U -f -S'

# handy tag command. makes rg sourcecode searching easy
if (( $+commands[tag] )); then
  tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null }
  alias ag=tag
fi

# }}}

# OS SPECIFIC {{{1

# OSX {{{2
if [ $MYOS = "DARWIN" ]; then
    alias brew='env -i "HOME=$HOME" "PATH=$PATH" "TERM=$TERM" brew'
    alias AI="brew install"
    alias AII="brew cask install"
    alias AS="cat ~/dotfiles/OSX/brew.available.list | grep -i"
    alias AD="brew info"
    alias ADD="brew cask info"
    AR() { brew unlink ${1:?} && brew uninstall ${1:?} }
    alias ARR="brew cask uninstall"
    alias AL="brew ls"
    alias ALL="brew cask ls"

    alias PAS="pip3 search"
    alias PAI="pip3 install"

    alias gg=google
    alias rm=trash

    alias kext-ls='kextstat | sort -k 6,6'
    alias kext-rebuild='kextcache -system-prelinked-kernel && kextcache -system-caches'

    alias launchctl-enable='sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist'

    alias lsblk='diskutil list'
    alias lsusb='system_profiler SPUSBDataType'
    alias mopidy="PYTHONPATH=$(brew --prefix)/lib/python2.7/site-packages mopidy --config ~/mopidy.conf"

    # -W wide -a all -p proto
    alias netstat-tcp='sudo netstat -Wap tcp'
    alias netstat-bps="netstat -I en0 -b -w 1"

    alias nettop='nettop -m tcp -t wired -k rtt_min,rx_dupe,rx_ooo,re-tx,rcvsize,tx_win,tc_class,tc_mgt,cc_algo,C,R,P,W'

    alias plist2xml='plutil -convert xml1'

    alias route-print='netstat -rn'
    alias route-add-temp='sudo route -n add 192.168.3.0/24 192.168.3.1'
    # this will reboot persist
    alias route-add='sudo  networksetup -setadditionalroutes Ethernet 192.168.3.123 255.255.255.0 192.168.3.1'
    alias route-del='sudo route -n delete 192.168.3.0/24 192.168.3.1'

    alias sort='LC_ALL= sort'
    alias syslog='sudo log show --last 6h'

    alias svc='sudo launchctl'
    alias xml2plist='plutil -convert binary1'

    osx-ps() {
        osascript -e 'tell application "System Events" to get the name of every process' | \
        sed -re 's/, /\n/g'
    }


    dash() { open dash://${1:?}:${2:?} }
# }}}

# DEBIAN {{{2
elif [ $MYOS = "UBUNTU" ]; then
    alias AI="sudo apt-get install"
    alias AR="sudo apt-get remove"
    alias AS="apt-cache search"
    alias AL="apt-file list"
    alias AF="apt-file find -x"
# }}}

# ARCH {{{2
elif [ $MYOS = "ARCH" ]; then
    alias AS="yay --color=auto -Ss"
    alias ASS="pacman -Ss --color=auto"
    alias AL="yay --color=auto -Ql --noconfirm"
    alias AR="yay --color=auto -R"
    alias AF="pkgfile"
    alias AU="yay --needed --color=auto -Syu"

    AI() {
        yay --needed --color=auto -S ${1:?}
        if [ $? -eq 0 ]; then
            if ! grep -Eq "^${1}$" "$HOME/dotfiles/install/pkg-lists/new_arch.txt" ; then
                echo $1 >> "$HOME/dotfiles/install/pkg-lists/new_arch.txt"
            fi
        fi
    }

    alias pac-update-all="pacaur --noconfirm -Syu"
    alias pac-list-aur-pkgs="pacaur -Qm | awk '{print \$1}'"
    alias pac-list-manual-pkgs="pacman -Qe | awk '{print \$1}'"
    alias pac-list-pkgs-in-group="pacman -Sgg"


    alias pacman-keyring-fix="sudo pacman-key --init && sudo pacman-key --populate && sudo pacman-key --refresh-keys && sudo pacman -Sy archlinux-keyring"
    alias pacman-mirror-update='sudo reflector --verbose -n 10 -c US --sort rate --save /etc/pacman.d/mirrorlist'
    alias netstat-listening='sudo ss -lptu'
    alias calc=pcalc

    alias svc='sudo systemctl'
    alias log='sudo journalctl -xe'

    AD() { yaourt -Qi ${1:?} | grep Depends | cut -d: -f2 }

    # -i interfaces. shows packets/sec
    alias netstat-bps="netstat -i"
    # -l listen -p PID -t TCP -u UDP -W wide
    alias netstat-listen='sudo netstat -l -p -t -u -W'

    alias route-print='route'


    # oh-my-zsh/blob/master/plugins/systemd/systemd.plugin.zsh
    user_commands=(
      list-units is-active status show help list-unit-files
      is-enabled list-jobs show-environment cat list-timers)

    sudo_commands=(
      start stop reload restart try-restart isolate kill
      reset-failed enable disable reenable preset mask unmask
      link load cancel set-environment unset-environment
      edit)

    for c in $user_commands; do; alias sc-$c="systemctl $c"; done
    for c in $sudo_commands; do; alias sc-$c="sudo systemctl $c"; done

    alias sc-enable-now="sc-enable --now"
    alias sc-disable-now="sc-disable --now"
    alias sc-mask-now="sc-mask --now"

    alias rpi-gpu='/opt/vc/bin/vcgencmd  get_mem gpu'
    alias rpi-temp='/opt/vc/bin/vcgencmd  measure_temp'

    compdef _pacman_completions_all_packages  AI
    compdef _pacman_completions_all_packages  AL
    compdef _z zz
    # compdef _systemctl svc
    # compdef _yay yay
    # compdef _yay AS
    # compdef _yay AI
    # compdef _yay AR
    # compdef _yay AU
    # compdef _cower AV
    # compdef _yay AL
    # compdef _pkgfile AF
# }}}

# MINGW {{{2
elif (os-get | awk '{ print $1 }' | grep MSYS) || (os-get | awk '{ print $1 }' | grep MINGW); then
    export LC_CTYPE=
    export LANG=
    export LC_ALL=
    alias AS="pacman --color auto -Ss"
    alias AI="pacman --color auto -S"
    alias AR="pacman --color auto -R"
    alias AU="pacman --color auto -Syu --aur"
    alias AV='cower --color --sort=votes -s'
    alias AL="pacman --color auto -Ql"
    alias AC="paccache -r"
    alias AF="pkgfile"
    alias rg="/usr/bin/rg.exe -S"

    alias posh_ps="sg_posh 'ps | select name,id,path' | rg -v svchost"
    ii() { explorer.exe /e, $( cygpath -w $(cd "$1"; pwd) ) }
    sg_posh() { powershell.exe -noprofile -nologo -command \" $@ \" }
    posh_K() { sg_posh Stop-Process  -Name \*${@}\* }
    windows() { [[ -n "$WINDIR" ]]; }

    export PATH=$PATH:/mingw64/bin
fi
# }}}

# }}}

# CD SHORTCUTS {{{1
alias cd.pkg='cd ~/.cache/yay'
alias cd.dot='cd ~/dotfiles'
alias cd.cfg='cd ~/dotfiles/config'
# }}}

# ALIAS ARG HELPERS {{{1
alias adb-ls-pkgs='adb shell pm list packages'
alias adb-shell-two='adb -s firetv:5555 shell'
alias adb-log-warn='adb logcat *:W'

alias arp-subnet='arp -a'

alias cP='rsync --progress'

alias curl-moz="curl -L -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30'"

# -d draw title -S sort files
alias feh-sort='feh -g 1440x900 -d -S filename'

# 0: CCW + vflip 1: 90C 2: 90CCW 3: 90CW + vflip   2,2: 180deg
alias ffmpeg-rotate='ffmpeg -i in.mov -vf "transpose=1" out.mov'
alias ffmpeg-quality='ffmpeg -i in.avi -c:a copy -c:v libx264 out.avi'
alias ffmpeg-resize='ffmpeg -i in.mp4 -vf scale=320:-1 out.mp4'

alias find-recent-mod='find -cmin -5'
# %p is the relpath, %T@ is unixtime. so very sortable. %t is simple ctime
alias find-print-tlm='find . -type f -printf "%T@ %p\n"'
alias find-most-files="du --inodes -S | sort -h"

alias gpg-fingerprint='gpg --verbose --fingerprint'
alias gpg-ls='gpg --list-keys'
alias gpg-export='gpg --armor --export'
alias gpg-encrypt='gpg --recipient PUBLIC-KEY-O-RECIPIANT --armor --output out.asc --encrypt file.txt'
alias gpg-decrypt='gpg --decrypt'
alias gpg-verify='gpg --verify file.sig'
alias gpg-sign='gpg --sign --default-key MY_PRIVATE_KEY_EMAIL --armor'
alias gpg-clearsign='gpg --clearsign --default-key MY_PRIVATE_KEY_EMAIL --armor'
alias gpg-detachsign='gpg --detach-sign --default-key MY_PRIVATE_KEY_EMAIL --armor'
alias gpg-editkey='gpg --edit-key'

alias grep-url="perl -ne '/(https?:\/\/.*?\/.*?\/.*?\/)/ && print \"\$1\n\"'"
alias grep-unicode="ag --nocolor \"[\x80-\xFF]\""

alias httrack-moz='httrack --display -F '\''Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30'\'

alias im=i3-msg

alias ip-external='curl ipinfo.io/ip'
alias iptables-ls='sudo iptables-save'

alias ip-up='sudo ip link set up dev'
alias ip-add='sudo ip a add 192.168.1.2/24 dev wlp3s0'
alias ip-flush='sudo ip addr flush dev enp0s25'
alias ip-route-add='sudo ip route add 172.16.5.0/24 via 10.0.0.101 dev eth0'
alias ip-stats='ip -h -s addr'

alias json-pp='python -mjson.tool'

alias locate-filename='locate -r "\/'
alias locate-all="locate --regex '.*'"

alias ls-uuid='ls -al /dev/disk/by-uuid'

alias lsof-pid='sudo lsof -p'
# -P no port names
alias lsof-listen='sudo lsof -iudp -itcp -stcp:listen -P'

alias ngrep-http="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"

# open ports on subnet. defaults to quick arp
alias nmap-subnet-quick='nmap 192.168.3.0/24'
# -A  = -O OS detection -sV version scanning -sC script scanning --traceroute
alias nmap-host-heavy='nmap -A 192.168.3.2'
# -s scantype -T tcp connect. better netstat
alias nmap-listen='sudo nmap -sT  localhost'
alias nmap-all-ports='sudo nmap -p- localhost'
# -sV version detection -sC default scripts
alias nmap-versions='sudo nmap -sV -sC localhost'

alias pandoc-epub2pdf="pandoc -f epub -t latex  --latex-engine=xelatex blah.epub -o"


alias python-dbg='python -m trace --trace'
alias python-webserver='python3 -m http.server'

alias rand-sh='echo $(( $(head -c 2 /dev/random | od -i  -An) % 10 ))'

alias xclip-c='xclip -selection clipboard'
alias xclip-p='xclip -selection clipboard -o'

alias prompt.lite="export RPROMPT='$PROMPT_TIME'"
alias prompt.full="export RPROMPT='$(__git_info) $PROMPT_TIME'"

# -r recurse -v verbose -a archive mode (checks TLM) -h human readable -z compression
alias rsync-basic='rsync -Rvahz --progress'

alias smb-ls='sudo smbclient -L eth0 -I localhost'

alias sed-strip-ansi='sed "s/\x1B\[\([0-9]\{1,2\}\(;[0-9]\{1,2\}\)\?\)\?[mGK]//g"'

alias sshfs-umount='fusermount3 -u'
alias sshfs-basic='sshfs alarm@alarmpi:  ~/mnt/alarm'

alias term-set-title='echo -ne "\e]0;$(hostname)\a"'

alias thumbnail-gen='mogrify -verbose -path thumbs/256  -thumbnail 256x256^ *(.)'

alias tmux-ls-keys='tmux list-keys'
alias tmux-window-hostname='tmux rename-window "$(hostname -s)"'

alias ttycast="ttyd -p 8888 bash -c 'tmux new-session -d -s cast \; split-window -d \; attach -t cast'"

alias useradd='useradd --create-home'

alias vnc-x11="sudo x11vnc -rfbauth /home/steve/.vnc/passwd  -auth guess  -geometry 1920x1080  -display :0"
alias vnc-kill="vncserver -kill :1"
alias vnc-nopasswd="vncserver :6 -SecurityTypes None  -geometry 2000x950"

alias wifi-scan='sudo iwlist wlan0 scan'

alias xmodmap-load='xmodmap /home/steve/.xmodmaprc > /tmp/blah 2>&1'
alias xorg-resolution='xdpyinfo | grep -B 1 -i resolution'

alias youtube-dl-best="youtube-dl -f bestvideo+bestaudio"
alias youtube-dl-mp3="youtube-dl -f bestaudio --extract-audio --audio-format mp3"
# -i ignore download errors like files no exist
alias youtube-dl-mp3-pl="youtube-dl -f bestaudio --extract-audio --yes-playlist --audio-format mp3 -i"

fullpath() { echo "$(cd "$(dirname "$1")"; pwd)/$(basename "$1")" }

# }}}

# FUNCTIONS {{{1

web-history() {
  local cols sep google_history o
  cols=$(( COLUMNS / 2 ))
  sep='{::}'

    google_history="$HOME/.config/google-chrome/Default/History"

  \cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}'
 }

web-history-open() {
  web-history | fzf -e --no-sort --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs xdg-open > /dev/null 2> /dev/null

}

K() {
    [ $# -ne 1 ] && echo 'gimme a search string' && return

    ps wwaxo pid,ppid,stat,args | grep -i $1 | grep -v grep | while read -r procx; do
        echo $procx
        echo
        read -q "yn?want to kill? "
        pid="$( echo "$procx" | awk '{ print $1 }')"
        echo

        case $yn in
            [Yy]* ) sudo kill -9 $pid;;
        esac
    done
}


man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[7;49;93m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
      man "$@"
}

pastebin() { curl -F "c=@${1:--}" https://ptpb.pw/ }

ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
            tmux rename-window "$*"
            command ssh "$@"
            tmux set-window-option automatic-rename "on" 1>/dev/null
    else
            command ssh "$@"
    fi
}


# homegrown lazy extractor
xx() {
    if [ $# -lt 1 -o  ! -f "$1" ]; then
        echo "gimme a filename to extract"
        return
    fi

    if echo "$1" | grep -q 'tar.gz$'; then
        7z x "$1" -so | 7z x -aoa -si -ttar -o"${1%.tar.gz}"
    else
        dirx="${1%.*}"
        ggg="7z x \"$1\" -o$dirx"
        echo $ggg
        7z x "$1" -o"${dirx}"
    fi
}

# reload zshrc
function zs()
{
    if autoload -U compinit -d "$XDG_CACHE_HOME/.zcompdump"; then
        compinit -d "$XDG_CACHE_HOME/.zcompdump"
    else
        echo 'compinit fudged up' >&2
    fi

   exec zsh
}

zsh-list-completions() {
    for command completion in ${(kv)_comps:#-*(-|-,*)}
    do
        printf "%-32s %s\n" $command $completion
    done | sort
}

# }}}




#f5# Create Directory and \kbd{cd} to it
function mkcd () {
    if (( ARGC != 1 )); then
        printf 'usage: mkcd <new-directory>\n'
        return 1;
    fi
    if [[ ! -d "$1" ]]; then
        command mkdir -p "$1"
    else
        printf '`%s'\'' already exists: cd-ing.\n' "$1"
    fi
    builtin cd "$1"
}

#f5# Create temporary directory and \kbd{cd} to it
function cdt () {
    builtin cd "$(mktemp -d)"
    builtin pwd
}

#f5# List files which have been accessed within the last {\it n} days, {\it n} defaults to 1
function accessed () {
    emulate -L zsh
    print -l -- *(a-${1:-1})
}

#f5# List files which have been changed within the last {\it n} days, {\it n} defaults to 1
function changed () {
    emulate -L zsh
    print -l -- *(c-${1:-1})
}

#f5# List files which have been modified within the last {\it n} days, {\it n} defaults to 1
function modified () {
    emulate -L zsh
    print -l -- *(m-${1:-1})
}

_pacman_pkg_fzf_info() {                                                                                                                                                                                                                          [18:43]
    if [[ -n $@ ]]
    then
        result=$(yay -Ssq $@ | fzf --preview 'yay -Si {}')
    else
        result=$( \
            (
        yay -Pc | awk '{ print $1}';
        ) | sort | fzf --preview 'yay -Si {}')
    fi

    yay -S $result
}
alias pg=_pacman_pkg_fzf_info

#f5# List aliases
_ali() {
    local cmd=$(grep -e '^alias' ~/.config/zsh/aliases.zsh | fzf --no-sort --cycle --tac |cut -d\= -f2)
    if [[ -n $cmd ]]
    then
        echo $cmd
        eval $cmd
    fi
}
alias ali=_ali


#f1# Provides useful information on globbing
function _hglob () {
    echo -e "
    /      directories
    .      plain files
    @      symbolic links
    =      sockets
    p      named pipes (FIFOs)
    *      executable plain files (0100)
    %      device files (character or block special)
    %b     block special files
    %c     character special files
    r      owner-readable files (0400)
    w      owner-writable files (0200)
    x      owner-executable files (0100)
    A      group-readable files (0040)
    I      group-writable files (0020)
    E      group-executable files (0010)
    R      world-readable files (0004)
    W      world-writable files (0002)
    X      world-executable files (0001)
    s      setuid files (04000)
    S      setgid files (02000)
    t      files with the sticky bit (01000)

  print *(m-1)          # Files modified up to a day ago
  print *(a1)           # Files accessed a day ago
  print *(@)            # Just symlinks
  print *(Lk+50)        # Files bigger than 50 kilobytes
  print *(Lk-50)        # Files smaller than 50 kilobytes
  print **/*.c          # All *.c files recursively starting in \$PWD
  print **/*.c~file.c   # Same as above, but excluding 'file.c'
  print (foo|bar).*     # Files starting with 'foo' or 'bar'
  print *~*.*           # All Files that do not contain a dot
  chmod 644 *(.^x)      # make all plain non-executable files publically readable
  print -l *(.c|.h)     # Lists *.c and *.h
  print **/*(g:users:)  # Recursively match all files that are owned by group 'users'
  echo /proc/*/cwd(:h:t:s/self//) # Analogous to >ps ax | awk '{print $1}'<"
}
alias help-zshglob=_hglob

# grep for running process, like: 'any vim'
function _any () {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]] ; then
        echo "any - grep for process(es) by keyword" >&2
        echo "Usage: any <keyword>" >&2 ; return 1
    else
        ps xauwww | grep -i "${grep_options[@]}" "[${1[1]}]${1[2,-1]}"
    fi
}
alias any=_any

function _edit_dotfiles() {
    # ret=$(fd . --type f --  ~/dotfiles | fzf)
    ret="$(git --git-dir=~/dotfiles/.git/ ls-files  | fzf)"

    [[ -z "$ret" ]] && return 1




}
alias ed=_edit_dotfiles


_viw() {
  vim $(which "$1")
}
alias viw=_viw

_gh_clone () {
    # input: usr/repo
    # USER=$(echo $@ | tr "/" " " | awk '{print $1}')
    # REPO=$(echo $@ | tr "/" " " | awk '{print $2}')
    cd "$HOME/src" &&  hub clone $@ && cd $@
}

alias gh=_gh_clone

