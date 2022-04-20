#!/bin/zsh

# brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# nvim
brew install node neovim ripgrep
python3 -m pip install --user --upgrade pynvim

brew install tree

# lsd
## [Icons render on MacOS](https://github.com/Peltoche/lsd/issues/199#issuecomment-494218334)
## need change iterm font
brew install lsd && brew tap homebrew/cask-fonts && brew install font-hack-nerd-font

## dev
brew install --cask devtoys iterm2 utools

## other
brew install --cask neteasemusic wechat

