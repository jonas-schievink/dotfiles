# Oh My Fish init
set -gx OMF_PATH "/home/jonas/.local/share/omf"
source $OMF_PATH/init.fish

eval (thefuck --alias | tr '\n' ';')

set PATH ~/.local/bin $PATH

set -x EDITOR vim

set -x RUST_BACKTRACE 1
set -x RUST_SRC_PATH ~/dev/rust/src
set -x RUST_NEW_ERROR_FORMAT true
set -x PATH $PATH ~/.cargo/bin  # needed for rustup to work

set -x PSPDEV /usr/local/pspdev
set -x PATH $PATH $PSPDEV/bin

set -x ANDROID_HOME /opt/android-sdk
set -x NDK_HOME /opt/android-ndk

set -x LD /usr/bin/ld.gold
set -x CC /usr/bin/clang
set -x CXX /usr/bin/clang++

# get rid of the annoying greeting
set fish_greeting

# make ssh-agent usable
set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/smith.socket"

# make 'less' pass colors through
alias 'less' 'less -R'
alias 'dmesg' 'dmesg --color=always'


# XDG workarounds
set -x MPLAYER_HOME ~/.config/mplayer
#set -x GNUPGHOME ~/.config/gnupg # FIXME this one breaks everything
set -x LESSHISTFILE ~/.cache/less/hist
alias 'svn' "svn --config-dir ~/.config/subversion"

