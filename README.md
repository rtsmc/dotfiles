# dotfiles

dotfiles for my laptop linux setup, which is based on Arch Linux and the Sway window manager.

This repo is managed as a bare git repo:

```sh
git clone --bare https://github.com/rtsmc/dotfiles.git "$HOME/.dotfiles"
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```
