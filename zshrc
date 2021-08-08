# xterm hack for some terminals to support 256 colors
if [ "$TERM" = "xterm" ]; then
  if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
  else
    export TERM='xterm-color'
  fi
fi

ZSH_CONFIG_DIR="$(dirname $(readlink -f $HOME/.zshrc))"

[ -z "$PS1" ] && return

. $ZSH_CONFIG_DIR/config.zsh
. $ZSH_CONFIG_DIR/bindings.zsh
#. $ZSH_CONFIG_DIR/completion.zsh
. $ZSH_CONFIG_DIR/functions.zsh
. $ZSH_CONFIG_DIR/aliases.zsh
. $ZSH_CONFIG_DIR/prompt.zsh

#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2
#export WORKON_HOME=~/.pyenv
#if [ -e /usr/bin/virtualenvwrapper_lazy.sh ]; then
#    source /usr/bin/virtualenvwrapper_lazy.sh
#fi
#
## CPAN
#export PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:$HOME/.perl5";
#export PERL_MB_OPT="--install_base ~/.perl5";
#export PERL_MM_OPT="INSTALL_BASE=~/.perl5";
#export PERL5LIB="$HOME/.perl5/lib/perl5:$PERL5LIB";
#export PATH="$PATH:~/.perl5/bin";

GPG_TTY=$(tty)
export GPG_TTY


# compsys initialization
autoload -U compinit
compinit

[ -e ~/.fzf.zsh ] && . ~/.fzf.zsh

[ -e $ZSH_CONFIG_DIR/custom.zsh ] && . $ZSH_CONFIG_DIR/custom.zsh

# fzf-tab settings	
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# newly opened terminal should clean prompt
true

# launch tmux
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi
