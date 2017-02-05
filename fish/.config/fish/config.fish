eval (thefuck --alias | tr '\n' ';')

# get rid of the annoying greeting
set fish_greeting

# unshortened directory names in prompt
set -g fish_prompt_pwd_dir_length 0

alias 'beep' 'notify-send "BEEP" "Pinged from shell."'

# make 'less' pass colors through
alias 'less' 'less -R'
alias 'dmesg' 'dmesg --color=always'

# btrfs/CoW support aliases
alias 'cp' 'cp --reflink=always'

