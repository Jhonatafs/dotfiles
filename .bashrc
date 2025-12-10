#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# My settings
#
# Local Scripts for PATH
export PATH="$HOME/.local/bin:$PATH"
#Git Bare
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
