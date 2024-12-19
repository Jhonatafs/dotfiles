#
# ~/.bashrc
#


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Customized PS1 with Dracula theme
export PS1="\[\033[0;32m\][\[\033[0m\]\[\033[0;32m\]\u@\h\[\033[0m\]\[\033[0;32m\]]\[\033[0m\]:\[\033[0;95m\][\[\033[0m\]\[\033[0;95m\]\w\[\033[0m\]\[\033[0;95m\]]\[\033[0m\]\\$ "
export CLICOLOR=1
# Dracula theme colors for ls on FreeBSD
LSCOLORS=ExFxBxDxCxegedabagacad

# Alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'
