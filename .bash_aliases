alias aa='screen -e ^]] -dR'
alias less='less --RAW-CONTROL-CHARS' # enable ANSI color control characters in files
alias l='ls -lFhG --color=auto'
alias ll='ls -laFh --color=auto'
alias g='grep -InE --color=always'
alias ig='grep -iInE --color=always'
alias pwgen='pwgen --symbols --ambiguous 16'

# be paranoid
alias cp='cp -ip'
alias mv='mv -i'
alias del='rm -i'

# git aliases
alias gits='git status'
alias gitst='git status --untracked-files=no'
alias gitd='git diff --color-words | fold'


# example of how aliases can take arguments!
#alias djm='darcs diff --diff-command="meld %1 %2"'

# fancy "aliases"
function em {
    emacs $@ &
}
function en {
    emacs -nw $@
}

function path {
    echo `pwd`/$1
}
function pathp {
    echo `pwd -P`/$1
}

function loc {
    find . -name $1 | xargs wc -l
}
