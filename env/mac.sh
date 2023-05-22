#!/bin/zsh
set -x

source util.sh || exit 1

# github already has brew installed
if [[ -z $GITHUB_ACTIONS ]]; then
  # brew
  which brew
  if [[ $? -eq 0 ]]; then
    brew update  ## Update homebrew itself and the package lists

    brew upgrade --formula

    # original brew can only pin formula not cask
    # [buo/homebrew-cask-upgrade](https://github.com/buo/homebrew-cask-upgrade) supports pinning cask
    # brew upgrade --cask --greedy
    brew cu pin adrive
    brew cu pin docker
    brew cu pin qq
    brew cu pin postman
    brew cu -a

    brew cleanup

    exit 0
  fi

  # install brew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  ## 去掉各种设置密码的规则限制
  ## https://apple.stackexchange.com/questions/337468/how-to-set-a-short-user-password-in-macos-mojave-and-later-10-14
  pwpolicy -clearaccountpolicies
fi

# suports `brew cu pin`
brew tap buo/cask-upgrade

# nvim
brew install node neovim ripgrep
python3 -m pip install --user --upgrade pynvim

brew install tree lrzsz

# lsd
## [Icons render on MacOS](https://github.com/Peltoche/lsd/issues/199#issuecomment-494218334)
## need change iterm font
brew install lsd && brew tap homebrew/cask-fonts && brew install font-hack-nerd-font

brew install fd bat procs zoxide bottom sk

# brew install mysql

## dev
brew install --cask devtoys iterm2 utools postman

## other
brew install --cask \
  logseq zotero \
  paper \
  appcleaner \
  maccy \
  maczip \
  v2rayu \
  yinxiangbiji \
  wechat \
  adrive thunder \
  neteasemusic qqmusic iina xld

# rust
install_rust

# aria2
# brew install aria2

exit 0

