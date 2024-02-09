export LESSHISTFILE="-"
export PATH=$PATH:"$HOME/scripts"
export PATH=$PATH:"$HOME/.local/bin"
export PATH=$PATH:"/opt/i2p"
export PATH=$PATH:"/usr/local/bin"
export PATH=$PATH:"/opt"
export PATH=$PATH:"$HOME/anaconda3/bin"
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="brave-browser-nightly"
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
export PYTHONSTARTUP="/etc/python/pythonrc"
export WINEPREFIX="$XDG_DATA_HOME"/wine
export PASSWORD_STORE_DIR="$HOME/.local/share/.password-store"
export GHCUP_USE_XDG_DIRS=true
export W3M_DIR="$XDG_DATA_HOME"/w3m
export PYTHONSTARTUP="/etc/python/pythonrc"
export ZSHZ_DATA="$HOME/.local/share/z"
export LD_LIBRARY_PATH=LD_LIBRARY_PATH:/usr/lib/jvm/java-11-openjdk/lib
export ZSH="$HOME/.config/oh-my-zsh"
export _JAVA_AWT_WM_NONREPARENTING=1


source $HOME/.alias

if { [ -z "${DISPLAY}" ] } && { [ "${XDG_VTNR}" -eq 1 ] || [ "${XDG_VTNR}" -eq 2 ]; } && { [ "$count" -eq 0 ] || [ "$count" -eq 1 ] } ;
then
    if command -v sx > /dev/null 2>&1;then
        sx $HOME/.xinitrc
    else
        startx $HOME/.xinitrc
    fi
fi

