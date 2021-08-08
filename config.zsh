#HISTORY
HISTFILE=~/.histfile
HISTSIZE=500000
SAVEHIST=500000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

setopt inc_append_history
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt hist_allow_clobber

#ZSH OPTS
setopt noclobber
setopt correct
setopt autolist
setopt auto_resume
setopt short_loops #for file in *.pdf; lp ${file}

unset beep
set nobeep

#LOAD PROFILE
if [ -x /etc/profile ]; then
    setopt -G
    . /etc/profile
    setopt +G
fi

#PATHs
export PATH="$PATH:$HOME/bin:$HOME/.config/local/bin"
export MANPATH="$MANPATH:$HOME/.config/local/share/man"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.config/local/lib"


#EDITORS
export EDITOR='nvim'
export VISUAL='nvim'

#PAGER
export PAGER='less'
export LESS=-ex3MRXSF
export LESS_TERMCAP_mb=$'\E[05;31m'
export LESS_TERMCAP_md=$'\E[05;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[05;47;30m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[05;32m'
export GROFF_NO_SGR=yes

#loading functions
autoload -Uz zmv

