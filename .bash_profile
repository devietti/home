# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1='${debian_chroot:+($debian_chroot)}:\w\$ '
    ;;
esac

# customize my login prompt!
if [ "$UID" -eq "0" ]  # Will the real "root" please stand up?
then
  export PS1="\[\e[0;33m\]\u@\h: \W#\[\e[0m\] "
else
  export PS1="\[\e[0;33m\]:\W\$\[\e[0m\] "
fi

# if test "$DISPLAY" ; then
#     # the original command from Colin
#     # export PROMPT_COMMAND='echo -ne "\033]30;`echo $PWD | sed -e "s/^.*\(.\{20\}\)>$/\1/" `\007\033]31;$PWD\007"'
#     # my modified version - neat-o, eh?
#     export PROMPT_COMMAND='echo -ne "\033]30;`if [ $EUID = "0" ]; then echo -n "root:"; fi; echo $PWD | sed -e "s/.*\([/][^/]*[/]\)/\1/" `\007\033]31;$PWD\007"'
# fi
#export PROMPT_COMMAND='echo -n -e "\033kfoobarbaz\033\\"'


# # If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
#     ;;
# screen*)
#     PROMPT_COMMAND='echo -n -e "\033k${PWD/$HOME/~}\033\\"'
#     ;;
# *)
#     ;;
# esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export EDITOR="/usr/bin/emacs"

export CVS_RSH=ssh
export RSH=ssh

# projects
# export PIN_HOME=/home/devietti/recherche/pin/source/tools/
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))

# set PATH

# my special scripts
export PATH=~/bin:$PATH
# cabal
export PATH=$PATH:~/Library/Haskell/bin

# have ocaml runtime generate backtraces for uncaught exceptions
export OCAMLRUNPARAM=b

export MALLOC_CHECK_=0

unset USERNAME

# $PAGER screws up viewing man pages
unset PAGER

# Alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
