function fuck -d 'Correct your previous console command'
    set -l exit_code $status
    set -l eval_script (mktemp 2>/dev/null ; or mktemp -t 'thefuck')
    set -l fucked_up_commandd $history[1]
    thefuck $fucked_up_commandd > $eval_script
    . $eval_script
    rm $eval_script
    if test $exit_code -ne 0
        history --delete $fucked_up_commandd
    end
end

set -x PATH /usr/local/bin /usr/bin /usr/bin/core_perl /opt/android-sdk/platform-tools ~/.local/bin

set -x ANDROID_HOME /opt/android-sdk
set -x NDK_HOME /opt/android-ndk

set -x RUST_NEW_ERROR_FORMAT true

set -x PSPDEV /usr/local/pspdev
set -x PATH $PATH $PSPDEV/bin

set -x LC_COLLATE C
set -x LANG en_US.UTF-8

set -x CC /usr/bin/clang
set -x CXX /usr/bin/clang++

# unfuck ~
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x WEECHAT_HOME "$XDG_CONFIG_HOME"/weechat
set -x MPLAYER_HOME "$XDG_CONFIG_HOME"/mplayer

