#zmodload zsh/zprof

zstyle ':completion:*' menu select
HIST_STAMPS="dd/mm/yyyy"
setopt prompt_subst

() {
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

local return_code="%(?..%F{red}%? ↵%f)"
local user_host="${PR_USER}%F{cyan}@${PR_HOST}"
local current_dir="%B%F{blue}%~%f%b"
local git_branch='$(git_prompt_info)'

PROMPT="╭─${user_host} ${current_dir} ${git_branch}
╰─$PR_PROMPT"
RPROMPT="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="›%f"
ZSH_THEME_RUBY_PROMPT_PREFIX="%F{red}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%f"

}

git_prompt_info () {
    if ! __git_prompt_git rev-parse --git-dir &> /dev/null || [[ "$(__git_prompt_git config --get oh-my-zsh.hide-info 2>/dev/null)" == 1 ]]
    then
        return 0
    fi
    local ref
    ref=$(__git_prompt_git symbolic-ref --short HEAD 2> /dev/null)  || ref=$(__git_prompt_git describe --tags --exact-match HEAD 2> /dev/null)  || ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null)  || return 0
    local upstream
    if (( ${+ZSH_THEME_GIT_SHOW_UPSTREAM} ))
    then
        upstream=$(__git_prompt_git rev-parse --abbrev-ref --symbolic-full-name "@{upstream}" 2>/dev/null)  && upstream=" -> ${upstream}"
    fi
    echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${ref:gs/%/%%}${upstream:gs/%/%%}$(parse_git_dirty)${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}


# git clone https://github.com/agkozak/zsh-z.git ~/.local/share/zsh/zsh-z
# git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.local/share/zsh/zsh-autosuggestions
# git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.local/share/zsh/fast-syntax-highlight
# git clone https://github.com/marlonrichert/zsh-autocomplete.git ~/.local/share/zsh/zsh-autocomplete


source ~/.local/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.local/share/zsh/zsh-z/zsh-z.plugin.zsh
source ~/.local/share/zsh/fast-syntax-highlight/fast-syntax-highlighting.plugin.zsh
# source ~/.local/share/zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

autoload -U +X compinit && compinit
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
set -o emacs

bindkey '\e[1;3D' backward-word  # Alt+Left
bindkey '\e[1;3C' forward-word   # Alt+Right
bindkey "^[[1;5C" forward-word   # Ctrl+Left
bindkey "^[[1;5D" backward-word  # Ctrl+Right
bindkey "^[[3~" delete-char      # <Del> to delete instead of ~ 
bindkey -M menuselect '^[[Z' reverse-menu-complete



#zprof
