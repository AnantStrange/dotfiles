#zmodload zsh/zprof

ZSH_THEME="gnzh"

zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 60
zstyle ':completion:*' menu select

HIST_STAMPS="dd/mm/yyyy"
plugins=(git zsh-autosuggestions z )

source $ZSH/oh-my-zsh.sh

autoload -U +X compinit && compinit
source $HOME/.alias

#zprof
