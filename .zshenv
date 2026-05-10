export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export EDITOR="nvim"
export XDG_CURRENT_DESKTOP=sway
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"

XDG_DATA_DIRS="$XDG_DATA_DIRS:$HOME/.local/share"
PATH="$HOME/.local/bin:$PATH"
. "$HOME/.cargo/env"
