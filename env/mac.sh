#!/bin/zsh
set -x

# brew
which brew
if [[ $? -eq 0 ]]; then
  brew update  ## Update homebrew itself and the package lists
  brew upgrade
  brew upgrade --cask
  brew cleanup

  exit 0
fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# nvim
brew install node neovim ripgrep
python3 -m pip install --user --upgrade pynvim

brew install tree

# lsd
## [Icons render on MacOS](https://github.com/Peltoche/lsd/issues/199#issuecomment-494218334)
## need change iterm font
brew install lsd && brew tap homebrew/cask-fonts && brew install font-hack-nerd-font

# https://formulae.brew.sh/cask/

## dev
brew install --cask devtoys iterm2 utools

## other
brew install --cask baiduinput yinxiangbiji \
  wechat \
  baidunetdisk adrive thunder \
  neteasemusic qqlive iina \
  flux

exit 0

