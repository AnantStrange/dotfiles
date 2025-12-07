setopt nullglob

# Dynamically add all subdirectories of ~/.scripts to PATH
for dir in "$HOME/scripts"/*(/N); do
    [ -d "$dir" ] && PATH="$PATH:$dir"
done

paths=(
    "$HOME/.local/bin"
    "/opt/i2p"
    "/usr/local/bin"
    "/opt"
    "$HOME/scripts"
    "$HOME/anaconda3/bin"
    "$HOME/.local/share/go/bin"
    "$HOME/.local/share/cargo/bin"
)

for dir in "${paths[@]}"; do
    [ -d "$dir" ] && PATH="$PATH:$dir"
done

export PATH

export EDITOR="nvim"
export TERMINAL="st"
# export BROWSER="brave-nightly"
export BROWSER="zen-browser"
export BROWSERS="zen-browser brave-nightly brave firefox vivaldi chromium qutebrowser"
export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export ANDROID_HOME="$XDG_DATA_HOME"/android
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export XCURSOR_PATH=/usr/share/icons:${XDG_DATA_HOME}/icons
export ANDROID_HOME="$XDG_DATA_HOME"/android
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle 
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql_history
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export WINEPREFIX="$XDG_DATA_HOME"/wine
export PASSWORD_STORE_DIR="$HOME/.local/share/.password-store"
export GHCUP_USE_XDG_DIRS=true
export W3M_DIR="$XDG_DATA_HOME"/w3m
export PYTHONSTARTUP="/etc/python/pythonrc"
export PYTHONPATH="$PYTHONPATH:$HOME/scripts"
export ZSHZ_DATA="$HOME/.local/share/z"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/jvm/java-11-openjdk/lib"
export ZSH="$HOME/.config/oh-my-zsh"
export _JAVA_AWT_WM_NONREPARENTING=1
export GOPATH="$HOME/.local/share/go"
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export CCACHE_DIR="/var/cache/ccache"
export github="git@github.com:AnantStrange/StrangeChat.git"
export LESSHISTFILE="-"
export NVM_DIR="$XDG_DATA_HOME/nvm"


source $HOME/.alias
if [[ -z "$DISPLAY" && ("$XDG_VTNR" -eq 1 || "$XDG_VTNR" -eq 2) ]]; then
    command -v sx >/dev/null 2>&1 && sx "$HOME/.xinitrc" || startx "$HOME/.xinitrc"
fi

# Source zshrc so login shells behave like interactive shells
source ~/.zshrc
