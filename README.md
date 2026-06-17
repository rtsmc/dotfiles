# dotfiles

Personal Linux dotfiles for a Sway-based desktop.

This repo is managed as a bare Git repository:

```sh
git clone --bare https://github.com/rtsmc/dotfiles.git "$HOME/.dotfiles"
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```
