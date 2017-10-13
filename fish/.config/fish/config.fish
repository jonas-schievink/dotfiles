if test -z "$DISPLAY"
    # not running in X11 -> environment not prepopulated (ie. SSH or kernel console session)
    # source .xsession as a bash script and import environment
    fenv source ~/.xsession
end

# get rid of the annoying greeting
set fish_greeting

# unshortened directory names in prompt
set -g fish_prompt_pwd_dir_length 0

alias 'beep' 'notify-send "BEEP" "Pinged from shell."'

if which hub > /dev/null 2>&1
    # use the GitHub "hub" cli for enhanced git operations
    alias 'git' 'hub'
end

# make 'less' pass colors through
alias 'less' 'less -R'
alias 'dmesg' 'dmesg --color=always'

# btrfs/CoW support aliases
alias 'cp' 'cp --reflink=auto'

