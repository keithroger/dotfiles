
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='\[\e[0;1;38;5;105m\]\u\[\e[0;1;38;5;105m\]@\[\e[0;1;38;5;105m\]\h \[\e[0;1;38;5;105m\]\W\[\e[0;1;38;5;105m\]:\[\e[0m\]'


export PATH="$PATH:/bin"
export PATH="$PATH:/home/kro/.local/bin"
alias config='/usr/bin/git --git-dir=/home/kro/.cfg/ --work-tree=/home/kro'

export GOPATH=/home/kro/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
