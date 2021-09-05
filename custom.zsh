# allows c^r bindings
source ~/.config/zsh/zsh-fzf-history-search/zsh-fzf-history-search.zsh 

# tab compleitions
source ~/.config/zsh/fzf-tab/fzf-tab.plugin.zsh

# fast-syntax-highlighting
source ~/.config/zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# autosuggestions
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# https://unix.stackexchange.com/questions/97843/how-can-i-search-history-with-text-already-entered-at-the-prompt-in-zsh
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# https://stackoverflow.com/questions/8638012/fix-key-settings-home-end-insert-delete-in-zshrc-when-running-zsh-in-terminat 
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# https://unix.stackexchange.com/questions/58870/ctrl-left-right-arrow-keys-issue
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
