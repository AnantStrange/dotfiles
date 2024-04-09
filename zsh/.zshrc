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

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

execute_myscript() {
    quickedit
    zle reset-prompt
}

madd() {
    for url in "$@"; do
        echo "$url" >> ~/Downloads/links
        echo "Added: $url"
    done
}

zle -N execute_myscript
bindkey '^[e' execute_myscript

export PATH=$PATH:"$HOME/.local/share/go/bin"
export GOPATH="$HOME/.local/share/go"

#zprof
