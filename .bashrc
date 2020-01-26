#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias neofetch='neofetch --color_blocks off'

[ 'id -u' = '0' ] && PS1='[$PWD] # > ' || PS1='[$PWD] $ > '
PS2='> '

export PS1 PS2

export HISTSIZE=2000
