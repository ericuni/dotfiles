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
brew install neovim ripgrep fd layzgit

# coc.nvim
brew install node
python3 -m pip install --user --upgrade pynvim
npm install -g neovim  ## make coc to work with gopls

# lsd
## [Icons render on MacOS](https://github.com/Peltoche/lsd/issues/199#issuecomment-494218334)
brew install lsd
## need change iterm font
brew tap homebrew/cask-fonts && brew install font-hack-nerd-font

brew install fd zoxide jq lazygit

# brew install mysql

## dev
brew install --cask devtoys wezterm postman tree
# lrzsz  ## wezterm does not support rz/sz

# blade and cxx
brew install ninja glog protobuf googletest google-benchmark gperftools

## other
brew install --cask \
  raycast \
  logseq obsidian zotero netnewswire \
  maczip \
  v2rayu \
  adrive nutstore thunder \
  iina

# rust
install_rust

# proxy
# usage: nohup gost -L "http://:8118" &
brew install gost

## video downloader: https://github.com/iawia002/lux
brew install lux

# aria2
# brew install aria2

# mas: MacOS App Store https://github.com/mas-cli/mas
brew install mas

## github does not support install MacOS App Store software
if [[ -z $GITHUB_ACTIONS ]]; then
  mas install 836500024   ## 微信
  mas install 515798947   ## MagicanLite
  mas install 508368068   ## GetPlainText
  mas install 1352778147  ## Bitwarden
  mas install 1639052102  ## pap.er
  mas install 1659622164  ## vidhub
  mas install 595615424   ## QQ音乐
  mas install 944848654   ## 网易云音乐
  mas install 1661733229  ## LocalSend
  # mas install 1585682577  ## Vimkey, Safari vim 键位模式操作, Chrome 使用插件 Surfingkeys
fi

## generate ssh key pair
if [[ ! -d $HOME/.ssh ]]; then
  mkdir $HOME/.ssh
fi
if [[ ! -f $HOME/.ssh/id_rsa ]]; then
  ## 默认应该会使用 $HOME/.ssh/id_rsa, 如果不行, 再用 -f 指定
  ssh-keygen -t rsa -q -N ""
fi

exit 0

