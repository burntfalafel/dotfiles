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
alias vfd='nvim $(fzf)'
alias cfd='cd $(find * -type d | fzf)'

#COLORFULNESS
alias grep="grep --colour"

#no vim to .vim corretion and expandig of aliases after sudo (tailing space)
alias sudo='nocorrect sudo '

#DIRS
alias -g ...='cd ../../'           #cd ...
alias -g ....='cd ../../../'       #cd ....
alias -g .....='cd ../../../../'   #cd .....

#sprunge paste service
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias ixio="curl -F 'f:1=<-' ix.io"

alias uu="udiskie-umount"
alias detach="udisks --detach"

alias pd="pushd"
alias pp="popd"

alias gl="git log --pretty=format:'%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]' --decorate --date=short"
alias ga="git add"
alias gap="git add -p"
alias gc="git commit --verbose"
alias gcm="git commit -m"
alias gc="git commit --amend --verbose"
alias gd="git diff"
alias gds="git diff --stat"
alias gdc="git diff --cache"
alias gpl="git pull"
alias gss="git status -s"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gb="git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"
alias make=$HOME/.config/zsh/colormake.sh
