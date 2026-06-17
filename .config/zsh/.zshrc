fpath+=${ZDOTDIR:-~}/.zsh_functions

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
# bindkey '^R' history-incremental-search-backward # useful if fzf shell completions aren't being used

source "$ZDOTDIR/.antidote/antidote.zsh"
antidote load

alias vi='nvim'
alias t='tmux'
alias ta='tmux attach'
alias la='ls -lah'
alias l='ls -lh'
alias va='source .venv/bin/activate'
alias killbg='kill ${${(v)jobstates##*:*:}%=*}'
open() { xdg-open "$@" >/dev/null 2>&1 &! }
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

bindkey -v
export KEYTIMEOUT=1

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$XDG_DATA_HOME/npm/bin:$PATH"

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[2 q';;      # block
        viins|main) echo -ne '\e[6 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[6 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[6 q' ;} # Use beam shape cursor for each new prompt.

bindkey -s '^G' 'tmux-sessionizer^M'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

git_prompt_info() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  if [[ -n $branch ]]; then
    local changes
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
      changes="*"
    else
      changes=""
    fi
    echo " %F{240}($branch$changes)%f"
  fi
}
setopt PROMPT_SUBST
dir=''
PROMPT='%F{blue}%(4~|%-1~/…/%2~|%4~)%f$(git_prompt_info) %(?.%F{green}.%F{red})%#%f '

source <(fzf --zsh)

# bun completions
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

. "$HOME/.local/share/../bin/env"
