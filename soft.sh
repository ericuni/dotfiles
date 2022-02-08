#!/bin/zsh

# nvim
brew install node neovim ripgrep
python3 -m pip install --user --upgrade pynvim

# lsd
## [Icons render on MacOS](https://github.com/Peltoche/lsd/issues/199#issuecomment-494218334)
brew install lsd && brew tap homebrew/cask-fonts && brew install font-hack-nerd-font

