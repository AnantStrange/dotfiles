# zmodload zsh/zprof
set -o emacs

zstyle ':completion:*' menu select

HIST_STAMPS="dd/mm/yyyy"
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.

setopt prompt_subst
GIT_PROMPT_EXECUTABLE="haskell"

source ~/.local/share/zsh/zsh-git-prompt/zshrc.sh
function update_prompt() {
    local PR_USER PR_USER_OP PR_PROMPT PR_HOST

    # Check the UID
    if [[ $UID -ne 0 ]]; then # normal user
        PR_USER='%F{green}%n%f'
        PR_USER_OP='%F{green}%#%f'
        PR_PROMPT='%f➤ %f'
    else # root
        PR_USER='%F{red}%n%f'
        PR_USER_OP='%F{red}%#%f'
        PR_PROMPT='%F{red}➤ %f'
    fi

    # Check if we are on SSH or not
    if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
        PR_HOST='%F{red}%M%f' # SSH
    else
        PR_HOST='%F{green}%m%f' # no SSH
    fi

    # Check if we are in a Python virtual environment
    if [[ -n "$VIRTUAL_ENV" ]]; then
        local venv_indicator=' (venv)'
    else
        local venv_indicator=''
    fi

    local user_host="${PR_USER}%F{cyan}@${PR_HOST} "
    local current_dir="%B%F{blue}%~%f%b"
    local current_dir="%B%F{blue}%~${venv_indicator}%f%b"  # Include venv indicator here


    PROMPT="╭─${user_host} ${current_dir} $(git_super_status) 
╰─$PR_PROMPT"
}

chpwd_functions+=(update_prompt)
precmd_functions+=(update_prompt) 
update_prompt

function preexec() {
    timer=$(date +%s%3N)
}

function precmd() {
    if [ $timer ]; then
        local now=$(date +%s%3N)
        local d_ms=$(($now-$timer))
        local d_s=$((d_ms / 1000))
        local ms=$((d_ms % 1000))
        local s=$((d_s % 60))
        local m=$(((d_s / 60) % 60))
        local h=$((d_s / 3600))
        if ((h > 0)); then elapsed=${h}h${m}m
        elif ((m > 0)); then elapsed=${m}m${s}s
        elif ((s >= 10)); then elapsed=${s}.$((ms / 100))s
        elif ((s > 0)); then elapsed=${s}.$((ms / 10))s
        else elapsed=${ms}ms
        fi

        export RPROMPT="%F{cyan}${elapsed} %{$reset_color%}"
        unset timer
    fi
}


# git clone https://github.com/agkozak/zsh-z.git ~/.local/share/zsh/zsh-z
# git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.local/share/zsh/zsh-autosuggestions
# git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.local/share/zsh/fast-syntax-highlight
# git clone https://github.com/olivierverdier/zsh-git-prompt.git ~/.local/share/zsh/zsh-git-prompt
# git clone https://github.com/marlonrichert/zsh-autocomplete.git ~/.local/share/zsh/zsh-autocomplete


source ~/.local/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.local/share/zsh/zsh-z/zsh-z.plugin.zsh
source ~/.local/share/zsh/fast-syntax-highlight/fast-syntax-highlighting.plugin.zsh
# source ~/.local/share/zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# autoload -U +X compinit && compinit
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

zmodload -i zsh/complist
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


bindkey '\e[1;3D' backward-word  # Alt+Left
bindkey '\e[1;3C' forward-word   # Alt+Right
bindkey "^[[1;5C" forward-word   # Ctrl+Left
bindkey "^[[1;5D" backward-word  # Ctrl+Right
bindkey "^[[3~" delete-char      # <Del> to delete instead of ~ 
bindkey -M menuselect '^[[Z' reverse-menu-complete


# zprof
