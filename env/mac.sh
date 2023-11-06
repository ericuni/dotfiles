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
    for app in adrive docker qq postman v2rayu logseq obsidian raycast
    do
      brew cu pin $app
    done
    brew cu -a

    brew cleanup

    exit 0
  fi

  # install brew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  ## 去掉各种设置密码的规则限制
  ## https://apple.stackexchange.com/questions/337468/how-to-set-a-short-user-password-in-macos-mojave-and-later-10-14
  pwpolicy -clearaccountpolicies

  ## 禁止.DS_Store生成
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
fi

# suports `brew cu pin`
brew tap buo/cask-upgrade

# nvim
brew install node neovim ripgrep
python3 -m pip install --user --upgrade pynvim
npm install -g neovim  ## make coc to work with gopls

brew install tree lrzsz

# lsd
## [Icons render on MacOS](https://github.com/Peltoche/lsd/issues/199#issuecomment-494218334)
## need change iterm font
brew install lsd && brew tap homebrew/cask-fonts && brew install font-hack-nerd-font

brew install fd bat procs zoxide bottom sk jq joshuto

# brew install mysql

## dev
brew install --cask devtoys wezterm postman

# blade and cxx
brew install ninja glog protobuf googletest google-benchmark gperftools

## other
brew install --cask \
  raycast \
  logseq obsidian zotero \
  paper \
  maczip \
  v2rayu \
  wechat \
  adrive nutstore thunder \
  neteasemusic qqmusic iina

# rust
install_rust

# proxy
# usage: nohup gost -L "http://:8118" &
brew install gost

# aria2
# brew install aria2

exit 0

