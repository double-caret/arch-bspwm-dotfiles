#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

LS_COLORS="$LS_COLORS:ow="; export LS_COLORS
PROMPT_DIRTRIM=1
PS1="\[\033[01;32m\] \u\[\033[01;34m\] \w \$\[\033[00m\] "
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
HISTCONTROL=ignoredups
VISUAL=vim;export VISUAL 
EDITOR=vim; export EDITOR
#complete -cf sudo
HISTSIZE=100000
HISTFILESIZE=100000
shopt -s checkwinsize


#enable some colors

man() {
    LESS_TERMCAP_md=$'\e[1;34m' \
    LESS_TERMCAP_me=$'\e[1;31m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[1;32m' \
    LESS_TERMCAP_ue=$'\e[1;31m' \
    LESS_TERMCAP_us=$'\e[1;33m' \
    command man "$@"
}
# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
