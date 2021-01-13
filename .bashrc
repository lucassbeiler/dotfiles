#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias neofetch='neofetch --color_blocks off'

[ 'id -u' = '0' ] && PS1='$\e[0;31m$HOSTNAME$\e[0;34m [\w] #\e[0m'||
PS1='\e[0;32m\u@\h\e[0;34m [\w] $\e[0m'
PS1=${PS1}'\n> '

#[ 'id -u' = '0' ] && PS1='[$PWD] # > ' || PS1='[$PWD] $ > '
#PS2='> '

#export PS1 PS2

export HISTSIZE=2000
