#!/bin/zsh
set -x

# brew
which brew
if [[ $? -eq 0 ]]; then
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
which cargo
if [[ $? -ne 0 ]]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
   && . $HOME/.cargo/env && export CARGO_NET_GIT_FETCH_WITH_CLI=true
fi

cd -

function install_rust_cmds() {
  for cmd in $@; do
    which $cmd
    if [[ $? -ne 0 ]]; then
      cargo install $cmd
    fi
  done
}

function install_rust_special_cmd() {
  cmd=$1
  pkg=$2

  which $cmd
  if [[ $? -ne 0 ]]; then
    cargo install $pkg
  fi
}

install_rust_cmds bat procs zoxide
install_rust_special_cmd btm bottom

exit 0

