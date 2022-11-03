#!/bin/zsh
set -x

source util.sh || exit 1

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

# github does not support direct password when using https, needs gcm
which git-credential-manager-core
if [[ $? -ne 0 ]]; then
  # https://github.com/GitCredentialManager/git-credential-manager/blob/main/README.md#download-and-install
  local version="2.0.785"
  curl https://github.com/GitCredentialManager/git-credential-manager/releases/download/v${version}/gcm-linux_amd64.${version}.deb >gcm.deb
  sudo dpkg -i gcm.deb
  git-credential-manager-core configure
  rm gcm.deb
fi

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
  local version="1.19.3"
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
  local version="v16.17.0"
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

cd -

# rust
install_rust
install_rust_cmds lsd zoxide
install_rust_special_cmd rg ripgrep
install_rust_special_cmd fd fd-find

exit 0

