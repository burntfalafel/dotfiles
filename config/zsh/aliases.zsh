#LS
case "$(uname)" in
    Linux)
        alias ls='ls --color=auto' ;;
    FreeBSD)
        alias ls='ls -G' ;;
esac

alias l='ls -lFh'     #size,show type,human readable
alias ll='ls -rtlh'   #long list,show almost all,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable

#EDITORS
alias e='nvim'
alias vim='nvim'
alias vi='nvim'
alias vim="nvim"
alias v="nvim"

#COLORFULNESS
alias grep="grep --colour"

#no vim to .vim corretion and expandig of aliases after sudo (tailing space)
alias sudo='nocorrect sudo '

#DIRS
alias -g ...='../../'           #cd ...
alias -g ....='../../../'       #cd ....
alias -g .....='../../../../'   #cd .....

#sprunge paste service
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias ixio="curl -F 'f:1=<-' ix.io"

alias uu="udiskie-umount"
alias detach="udisks --detach"

alias pd="pushd"
alias pp="popd"
