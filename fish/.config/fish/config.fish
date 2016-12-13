eval (thefuck --alias | tr '\n' ';')

set PATH ~/.local/bin $PATH

set -x EDITOR vim
set -x VISUAL $EDITOR

set -x ANDROID_HOME /opt/android-sdk
set -x NDK_HOME /opt/android-ndk

# get rid of the annoying greeting
set fish_greeting

# make ssh-agent usable
set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/smith.socket"

alias 'beep' 'notify-send "BEEP" "Pinged from shell."'

# make 'less' pass colors through
alias 'less' 'less -R'
alias 'dmesg' 'dmesg --color=always'

# btrfs/CoW support aliases
alias 'cp' 'cp --reflink=always'

