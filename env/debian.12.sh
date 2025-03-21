#!/bin/zsh
set -x

# source util.sh || exit 1

sudo apt install zsh

# 需要输入密码, 但是又不能直接sudo, 否则改的是root 的shell, 因此需要先通过sudo 修改用户的密码, 然后再修改用户的shell
# 然后机器需要物理重启才能生效
# chsh -s $(which zsh)

which brew
if [[ $? -ne 0 ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install ripgrep fd fzf lsd zoxide starship
brew install jq git-delta

# WhichKey.nvim requires Neovim 0.9 or higher
# coc.nvim ctrl-j 跳转位置生效被snippet 干扰时(<Plug>(coc-snippets-expand-jump)), 需要安装下 CocInstall coc-snippets
brew install neovim node

# rust
# sudo apt install cmake pkg-config libssl-dev
# install_rust
# install_rust_cmds bat killport bandwhich
# install_rust_special_cmd tspin tailspin  # color log

# mkdir -p ~/sdk

# golang
which go
if [[ $? -ne 0 ]]; then
  brew install go@1.22
  go install golang.org/dl/go1.22.8@latest
  ~/go/bin/$go download
else
  which mockgen
  if [[ $? -ne 0 ]]; then
    go install github.com/golang/mock/mockgen@latest
  fi

  which lazygit
  if [[ $? -ne 0 ]]; then
    go install github.com/jesseduffield/lazygit@latest
  fi

  which gopls
  if [[ $? -ne 0 ]]; then
    go install golang.org/x/tools/gopls@v0.16.2
  fi
fi

