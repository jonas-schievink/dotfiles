#!/usr/bin/bash

# This is sourced as a bash script

# when running under X11, load the Xresources now
[ -n "$DISPLAY" ] && xrdb -merge ~/.config/X11/Xresources

export PATH=~/.local/bin:$PATH

export EDITOR="nvim"
export VISUAL="$EDITOR"

export ANDROID_HOME="/opt/android-sdk"
export NDK_HOME="/opt/android-ndk"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/smith.socket"

# make scrolling nicer
export MOZ_USE_XINPUT2=1

# XDG directory support
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_DOWNLOAD_DIR=~/downloads
export XDG_PICTURES_DIR=~/share/pictures
# prevent ~/Desktop from being created automatically
export XDG_DESKTOP_DIR=~

# configure various storage directories
export GIMP2_DIRECTORY="$XDG_CONFIG_HOME"/gimp
export __GL_SHADER_DISK_CACHE_PATH="$XDG_CACHE_HOME"/nv
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export WINEPREFIX="$XDG_DATA_HOME"/wine
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer
export MEDNAFEN_HOME="$XDG_CONFIG_HOME"/mednafen
export LESSHISTFILE=-   # Disables history
export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export EM_CONFIG="$XDG_CONFIG_HOME"/emscripten/config
export EM_CACHE="$XDG_CACHE_HOME"/emscripten/cache
export EM_PORTS="$XDG_DATA_HOME"/emscripten/cache
export ATOM_HOME="$XDG_DATA_HOME"/atom
export HISTFILE="$XDG_DATA_HOME"/bash/history
export VIMPERATOR_INIT=":source $XDG_CONFIG_HOME/vimperator/vimperatorrc"
export VIMPERATOR_RUNTIME="$XDG_CONFIG_HOME"/vimperator
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export WEECHAT_HOME="$XDG_CONFIG_HOME"/weechat

# other stuff that rarely changes:
export ASEPRITE_ACCEPT_EULA=yes

# FIXME This breaks everything. Figure out why! :(
#export XAUTHORITY="$XDG_RUNTIME_DIR"/X11/xauthority

# Export unique env var to enable on-demand loading of this file.
# This is used to avoid a costly environment import on fish startup.
export XSESSION_LOADED=1

