#!/bin/zsh
set -x

source util.sh || exit 1

# brew
# [Conditional Expressions](https://zsh.sourceforge.io/Doc/Release/Conditional-Expressions.html)
which brew
if [[ $? -eq 0 && -z $GITHUB_ACTIONS ]]; then
  brew update  ## Update homebrew itself and the package lists
  brew upgrade
  brew upgrade --cask --greedy
  brew cleanup

  exit 0
fi

## 去掉各种设置密码的规则限制
## https://apple.stackexchange.com/questions/337468/how-to-set-a-short-user-password-in-macos-mojave-and-later-10-14
pwpolicy -clearaccountpolicies

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# nvim
brew install node neovim ripgrep
python3 -m pip install --user --upgrade pynvim

brew install tree lrzsz

# lsd
## [Icons render on MacOS](https://github.com/Peltoche/lsd/issues/199#issuecomment-494218334)
## need change iterm font
brew install lsd && brew tap homebrew/cask-fonts && brew install font-hack-nerd-font

## dev
brew install --cask devtoys iterm2 utools postman

## other
brew install --cask baiduinput \
  maczip \
  v2rayu \
  yinxiangbiji \
  wechat \
  baidunetdisk adrive thunder \
  neteasemusic qqlive qqmusic iina

# rust
install_rust
install_rust_cmds bat procs zoxide
install_rust_special_cmd btm bottom

exit 0

