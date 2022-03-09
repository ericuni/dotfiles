#!/bin/zsh

# Debian 9 linux 4.14

cd ~
if [[ ! -d opt ]]; then
  mkdir opt
fi

cd opt

# neovim
which nvim
if [[ $? -ne 0 ]]; then
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod +x nvim.appimage
  ./nvim.appimage --appimage-extract
  mv squashfs-root nvim
  sudo ln -sf ~/opt/nvim/AppRun /usr/bin/nvim
fi

# golang
if [[ ! -e go ]]; then
  local version="1.17.8"
  curl https://dl.google.com/go/go${version}.linux-amd64.tar.gz >go.tar.gz
  tar zxf go.tar.gz
  mv go go${version}
  ln -sf go${version} go
fi

# node
if [[ ! -e node ]]; then
  local version="v16.14.0"
  curl https://nodejs.org/dist/${version}/node-${version}-linux-x64.tar.xz >node.tar.xz
  xz -d node.tar.xz
  tar xf node.tar
  ln -sf node-${version}-linux-x64 node
  rm node.tar
fi

# rust
which cargo
if [[ $? -ne 0 ]]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
   && . $HOME/.cargo/env && export CARGO_NET_GIT_FETCH_WITH_CLI=true
fi

cd -

cargo install lsd ripgrep

exit 0

