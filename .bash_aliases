alias less='less --RAW-CONTROL-CHARS' # enable ANSI color control characters in files
alias ls='ls -G'
alias l='ls -lFhG'
alias ll='ls -laFhG'
alias g='grep -InE --color=always'
alias ig='grep -iInE --color=always'
alias pwgen='pwgen --symbols --ambiguous 16'

# be paranoid
alias cp='cp -ip'
alias mv='mv -i'
alias del='rm -i'

# git aliases
alias gits='git status'
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