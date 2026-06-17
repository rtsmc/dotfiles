# dotfiles

Personal Linux dotfiles for a Sway-based desktop.

This repo is managed as a bare Git repository:

```sh
git clone --bare https://github.com/rtsmc/dotfiles.git "$HOME/.dotfiles"
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

Tracked config covers Sway, Waybar, Ghostty, tmux, zsh, Neovim, rofi, dunst,
fontconfig, keyd, and a few local helper scripts.

Secrets, credentials, shell history, and machine-local state should stay out of
this repository.
