#!/bin/zsh
set -x

# Debian 9 linux 4.14

which zsh
if [[ $? -ne 0 ]]; then
  sudo apt install zsh
fi

cd ~
if [[ ! -d opt ]]; then
  mkdir opt
fi

cd opt

# neovim
which nvim
if [[ $? -ne 0 ]]; then
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
  tar zxf nvim-linux64.tar.gz
  mv nvim-linux64 nvim
  rm nvim-linux64.tar.gz
fi

# golang
if [[ ! -e go ]]; then
  local version="1.17.10"
  curl https://dl.google.com/go/go${version}.linux-amd64.tar.gz >go.tar.gz
  tar zxf go.tar.gz
  mv go go${version}
  ln -sf go${version} go
  rm go.tar.gz
fi

which go
if [[ $? -eq 0 ]]; then
  which gopls
  if [[ $? -ne 0 ]]; then
    go install golang.org/x/tools/gopls@latest
  fi
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

which npm
if [[ $? -eq 0 ]]; then
  npm list -g | grep neovim
  if [[ $? -ne 0 ]]; then
    npm install -g neovim  ## make coc to work with gopls
  fi
fi

# protoc
which protoc
if [[ $? -ne 0 ]]; then
  mkdir protoc
  cd protoc

  local version="21.5"
  curl -L https://github.com/protocolbuffers/protobuf/releases/download/v${version}/protoc-${version}-linux-x86_64.zip >protoc.zip
  unzip protoc.zip
  rm protoc.zip

  version="1.28.1"
  curl -L https://github.com/protocolbuffers/protobuf-go/releases/download/v${version}/protoc-gen-go.v${version}.linux.amd64.tar.gz >protoc-gen-go.tar.gz
  tar xf protoc-gen-go.tar.gz
  mv protoc-gen-go bin/
  rm protoc-gen-go.tar.gz
fi

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

install_rust_cmds lsd

which rg
if [[ $? -ne 0 ]]; then
  cargo install ripgrep
fi

which fd
if [[ $? -ne 0 ]]; then
  cargo install fd-find
fi

exit 0

