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

# customize my login prompt!
if [ "$UID" -eq "0" ]  # Will the real "root" please stand up?
then
# red background, yellow text
  export PS1="\[\e[41;33m\]\u@\h: \W#\[\e[0m\] "
elif [ "$USER" = "devietti" ]
then
# blue text
  export PS1="\[\e[34m\]d@\h:\W\$\[\e[0m\] "
else
# blue background, yellow text
  export PS1="\[\e[44;33m\]\u@\h:\W\$\[\e[0m\] "
fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export EDITOR="/usr/bin/emacs -nw"

export CVS_RSH=ssh
export RSH=ssh

# projects
# export PIN_HOME=/home/devietti/recherche/pin/source/tools/
which javac > /dev/null
if [ $? -eq 0 ]
then
    export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))
fi

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
