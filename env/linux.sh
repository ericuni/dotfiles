#!/bin/zsh
set -x

source util.sh || exit 1

# Debian 10.12

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
  # [version `GLIBC_2.29' not found with latest appimage](https://github.com/neovim/neovim/issues/19711)
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x nvim.appimage
  ./nvim.appimage --appimage-extract
  mv squashfs-root/usr nvim
  rm nvim.appimage
fi

# golang
if [[ ! -e go ]]; then
  local out="go_version.html"
  curl "https://go.dev/dl/" >$out || exit 1
  # <a class="download downloadBox" href="/dl/go1.19.5.windows-amd64.msi">
  # <a class="download downloadBox" href="/dl/go1.19.5.darwin-arm64.pkg">
  # <a class="download downloadBox" href="/dl/go1.19.5.darwin-amd64.pkg">
  # <a class="download downloadBox" href="/dl/go1.19.5.linux-amd64.tar.gz">
  # <a class="download downloadBox" href="/dl/go1.19.5.src.tar.gz">
  local version=`cat $out | grep "download downloadBox" | head -n 1 | awk -F "go" '{print $2}' | awk -F ".windows" '{print $1}'`
  rm $out

  # many thirdparty dependency have not supportted go 1.20 yet
  version="1.19.7"

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

  which mockgen
  if [[ $? -ne 0 ]]; then
    go install github.com/golang/mock/mockgen@latest
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

# github does not support direct password when using https, needs gcm
which git-credential-manager-core
if [[ $? -ne 0 ]]; then
  # https://github.com/GitCredentialManager/git-credential-manager/blob/main/README.md#download-and-install
  local version="2.0.935"
  curl -L https://github.com/GitCredentialManager/git-credential-manager/releases/download/v${version}/gcm-linux_amd64.${version}.deb >gcm.deb
  sudo dpkg -i gcm.deb
  git-credential-manager-core configure
  rm gcm.deb
fi

which docker
if [[ $? -ne 0 ]]; then
  # [Install Docker Engine on Debian](https://docs.docker.com/engine/install/debian/)
  # [Install static binaries](https://docs.docker.com/engine/install/binaries/)

  # step 1: setup repository
  cat /etc/apt/sources.list.d/docker.list | grep docker
  if [[ $? -ne 0 ]]; then
    # uninstall old versions
    sudo apt-get remove docker docker-engine docker.io containerd runc

    sudo apt-get update
    sudo apt-get install ca-certificates curl gnupg

    sudo mkdir -m 0755 -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  fi

  # step 2: install docker
  # time consuming, download is very slow
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  # step 3: verify docker
  sudo docker run hello-world

  # step 4: no need sudo
  # [How to Fix Docker Permission Denied Error on Ubuntu](https://linuxhandbook.com/docker-permission-denied/)
  sudo groupadd docker
  sudo usermod -aG docker $USER
  newgrp docker
  docker images
fi

exit 0

