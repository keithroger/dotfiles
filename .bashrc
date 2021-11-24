#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='\[\e[0;1;38;5;105m\]\u\[\e[0;1;38;5;105m\]@\[\e[0;1;38;5;105m\]\h \[\e[0;1;38;5;105m\]\W\[\e[0;1;38;5;105m\]:\[\e[0m\]'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kro/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kro/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kro/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kro/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# Created by `pipx` on 2021-10-13 05:40:43
export PATH="$PATH:/home/kro/.local/bin"
alias config='/usr/bin/git --git-dir=/home/kro/.cfg/ --work-tree=/home/kro'
