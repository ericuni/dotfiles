#!/bin/zsh
set -x

source util.sh || exit 1

# latest Ubuntu Docker

which nvim
if [[ $? -ne 0 ]]; then
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.deb
  apt install ./nvim-linux64.deb
  rm nvim-linux64.deb
fi

cd ~
if [[ ! -d opt ]]; then
  mkdir opt
fi

cd opt

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

cd ~

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
  dpkg -i gcm.deb
  git-credential-manager-core configure
  rm gcm.deb
fi

exit 0

