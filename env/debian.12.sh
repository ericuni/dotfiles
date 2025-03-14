#!/bin/zsh
set -x

source util.sh || exit 1

sudo apt install zsh jq direnv

# 需要输入密码, 但是又不能直接sudo, 否则改的是root 的shell, 因此需要先通过sudo 修改用户的密码, 然后再修改用户的shell
# 然后机器需要物理重启才能生效
# chsh -s $(which zsh)

# rust
sudo apt install cmake pkg-config libssl-dev
install_rust
install_rust_cmds lsd zoxide starship bat killport bandwhich
install_rust_special_cmd rg ripgrep
install_rust_special_cmd fd fd-find
install_rust_special_cmd delta git-delta
install_rust_special_cmd tspin tailspin  # color log

mkdir -p ~/sdk/bin

# fzf in apt 版本太低了
which fzf
if [[ $? -ne 0 ]]; then
  cd ~/sdk
  if [[ ! -d fzf.tar.gz ]]; then
    curl -L https://github.com/junegunn/fzf/releases/download/v0.60.3/fzf-0.60.3-linux_amd64.tar.gz >fzf.tar.gz
    tar zxf fzf.tar.gz
    mv fzf bin
  fi
fi

# golang
go=go1.22.8
which $go
if [[ $? -ne 0 ]]; then
  cd ~/sdk

  if [[ ! -d go ]]; then
    curl -L https://go.dev/dl/$go.linux-amd64.tar.gz >go.tar.gz || exit 1
    tar zxf go.tar.gz
  fi

  which $go
  if [[ $? -ne 0 ]]; then
    cd go/bin
    ./go install golang.org/dl/$go@latest
    ~/go/bin/$go download
  fi
else
  which mockgen
  if [[ $? -ne 0 ]]; then
    $go install github.com/golang/mock/mockgen@latest
  fi

  which lazygit
  if [[ $? -ne 0 ]]; then
    $go install github.com/jesseduffield/lazygit@latest
  fi

  which gopls
  if [[ $? -ne 0 ]]; then
    $go install golang.org/x/tools/gopls@v0.16.2
  fi
fi

# neovim
# WhichKey.nvim requires Neovim 0.9 or higher
# coc.nvim ctrl-j 跳转位置生效被snippet 干扰时, 需要安装下 CocInstall coc-snippets
which nvim
if [[ $? -ne 0 ]]; then
  cd ~/sdk
  if [[ ! -d nvim-linux-x86_64 ]]; then
    curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz >nvim.tar.gz
    tar zxf nvim.tar.gz
  fi
fi

# node
if [[ ! -e node ]]; then
  cd ~/sdk
  version="v22.14.0"
  curl -L https://nodejs.org/dist/${version}/node-${version}-linux-x64.tar.xz >node.tar.xz
  xz -d node.tar.xz
  tar xf node.tar
  ln -sf node-${version}-linux-x64 node
fi

