# zmodload zsh/zprof
set -o emacs
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

HIST_STAMPS="dd/mm/yyyy"
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt prompt_subst

[ -f "$HOME/.alias" ] && source "$HOME/.alias"

# complist is a Zsh module (zsh/complist) that provides enhanced completion listing features, like menu selection.
zmodload -i zsh/complist

execute_myscript() {
    quickedit.sh
    zle reset-prompt
}

zle -N execute_myscript
bindkey '^[e' execute_myscript
bindkey '\e[1;3D' backward-word  # Alt+Left
bindkey '\e[1;3C' forward-word   # Alt+Right
bindkey "^[[1;5C" forward-word   # Ctrl+Left
bindkey "^[[1;5D" backward-word  # Ctrl+Right
bindkey "^[[3~" delete-char      # <Del> to delete instead of ~ 
bindkey -M menuselect '^[[Z' reverse-menu-complete

command -v fzf &>/dev/null && eval "$(fzf --zsh)"
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"

[ -f "/etc/arch-release" ] && ZSH_PLUGIN_DIR="/usr/share/zsh/plugins" || ZSH_PLUGIN_DIR="$HOME/.local/share/zsh"
source "$ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH_PLUGIN_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
source "$ZSH_PLUGIN_DIR/zsh-z/zsh-z.plugin.zsh"
# source "$ZSH_PLUGIN_DIR/zsh-autocomplete/zsh-autocomplete.plugin.zsh"

# autoload makes compinit available without immediately executing it.
# -U prevents functions from being redefined.
# -z ensures it's treated as a shell function.
autoload -Uz compinit && compinit -C
# if [[ ! -f ~/.zcompdump || $(find ~/.zcompdump -mmin +1440 2>/dev/null) ]]; then
#     compinit -C
# fi

[[ -n $SSH_TTY || "$TERM" == "linux" ]] && PS1='%n@%m:%~%# ' || eval "$(starship init zsh)" 

# zprof
