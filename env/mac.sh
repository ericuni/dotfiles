#!/bin/zsh
set -x

source util.sh || exit 1

action="update"

# always run init in Github Actions
if [[ -n $GITHUB_ACTIONS ]]; then
  action="init"
fi

# brew
which brew
if [[ $? -ne 0 ]]; then
  # official
  # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # 清华mirror
  export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
  export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
  export HOMEBREW_INSTALL_FROM_API=1
  git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git brew-install
  /bin/bash brew-install/install.sh || exit 1
  rm -rf brew-install

  echo >> ~/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  echo '# Set non-default Git remotes for Homebrew/brew and Homebrew/homebrew-core.' >> ~/.zprofile
  echo 'export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"' >> ~/.zprofile
  echo 'export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"' >> ~/.zprofile
fi

if [[ $action == "update" ]]; then
  brew update  ## Update homebrew itself and the package lists

  brew upgrade --formula

  # original brew can only pin formula not cask
  # [buo/homebrew-cask-upgrade](https://github.com/buo/homebrew-cask-upgrade) supports pinning cask
  # brew upgrade --cask --greedy
  # brew cu pin app
  brew cu -a

  brew cleanup

  exit 0
fi

# 去掉各种设置密码的规则限制
# https://apple.stackexchange.com/questions/337468/how-to-set-a-short-user-password-in-macos-mojave-and-later-10-14
# pwpolicy -clearaccountpolicies

# 开盖自动开机功能, 之后还需要重启下
# sudo nvram AutoBoot=%00

## 禁止.DS_Store生成
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

# https://github.com/buo/homebrew-cask-upgrade
# suports `brew cu pin`
brew tap buo/cask-upgrade

# nvim
brew install neovim ripgrep fd lazygit jq

# coc.nvim
brew install node
# TODO: error: externally-managed-environment, use pipx
# python3 -m pip install --user --upgrade pynvim
# npm install -g neovim  ## make coc to work with gopls

# https://github.com/sindresorhus/clipboard-cli
# echo xxx | clipboard, 这样 xxx 就在剪贴板中了, mac 有自带的 pbcopy & pbpaste
# npm install --global clipboard-cli

# lsd
## [Icons render on MacOS](https://github.com/Peltoche/lsd/issues/199#issuecomment-494218334)
brew install lsd
## need change iterm font
brew install --cask font-hack-nerd-font

brew install zoxide fzf starship direnv

# brew install mysql

## dev
brew install tree git-delta
brew install --cask wezterm apifox
# brew install tailspin bandwhich  # sudo bandwhich
# lrzsz  ## wezterm does not support rz/sz

# blade and cxx
brew install ninja glog protobuf googletest google-benchmark gperftools

## other
brew install --cask \
  raycast \
  logseq obsidian zotero netnewswire \
  maczip \
  adrive nutstore thunder \
  iina

# rust
install_rust

# python
brew install pipx
pipx install pytest

# proxy
# usage: nohup gost -L "http://:8118" &
brew install gost

## video downloader: https://github.com/iawia002/lux
# brew install lux

# brew install aria2 v2rayu

# mas: MacOS App Store https://github.com/mas-cli/mas
brew install mas

## github does not support install MacOS App Store software
if [[ -z $GITHUB_ACTIONS ]]; then
  mas install 1228738830  ## NetWorker Lite
  mas install 836500024   ## 微信
  mas install 508368068   ## GetPlainText
  # mas install 1352778147  ## Bitwarden
  mas install 1639052102  ## pap.er
  mas install 1659622164  ## vidhub
  mas install 595615424   ## QQ音乐
  mas install 944848654   ## 网易云音乐
  mas install 1661733229  ## LocalSend
  # mas install 1585682577  ## Vimkey, Safari vim 键位模式操作, Chrome 使用插件 Surfingkeys
fi

# ssh-keygen -t rsa -C ${email}

exit 0

