#!/bin/zsh
set -x

function append_path() {
  for p in $@; do
    [[ -d $p ]] && [[ ! $PATH =~ $p ]] && export PATH=$p:$PATH
  done
}

# 使用具有区分度的email, 例如 ericuni@home
# ssh-keygen -t rsa -C ${email}

which zsh
if [[ $? -ne 0 ]]; then
  sudo apt install zsh
fi
# linux 修改默认的bash shell 为zsh shell
# chsh 需要输入密码, 但是又不能直接sudo, 否则改的是root 的shell.
# 因此需要先通过sudo 修改用户的密码(sudo passwd `whoami`), 然后再修改用户的shell. 然后机器需要物理重启才能生效
# chsh -s $(which zsh)

# proxy_loc="127.0.0.1:8118"
# export http_proxy=$proxy_loc
# export https_proxy=$proxy_loc

# brew
which brew
if [[ $? -ne 0 ]]; then
  # official
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  append_path /home/linuxbrew/.linuxbrew/bin # for linux
  append_path /opt/homebrew/bin

  # 如果官方的安装失败, 使用清华mirror
  # export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
  # export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
  # export HOMEBREW_INSTALL_FROM_API=1
  # git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git brew-install
  # /bin/bash brew-install/install.sh || exit 1
  # rm -rf brew-install
  #
  # echo >> ~/.zprofile
  # echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  # echo '# Set non-default Git remotes for Homebrew/brew and Homebrew/homebrew-core.' >> ~/.zprofile
  # echo 'export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"' >> ~/.zprofile
  # echo 'export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"' >> ~/.zprofile
fi

brew install zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting

# if you receive "zsh compinit: insecure directories" warnings, you may need to run these commands:
#   chmod go-w '/opt/homebrew/share'
#   chmod -R go-w '/opt/homebrew/share/zsh'
brew install zsh-completions

brew install ripgrep fd fzf lsd zoxide starship
brew install jq lazygit git-delta
brew install tree btop

## [lsd icons render on MacOS](https://github.com/Peltoche/lsd/issues/199#issuecomment-494218334)
brew install --cask font-hack-nerd-font

# neovim
# WhichKey.nvim requires Neovim 0.9 or higher
# coc.nvim ctrl-j 跳转位置生效被snippet 干扰时(<Plug>(coc-snippets-expand-jump)), 需要安装下 CocInstall coc-snippets
brew install neovim node

# golang
which go
if [[ $? -ne 0 ]]; then
  brew install go
  append_path /home/linuxbrew/.linuxbrew/opt/go/bin
  append_path /opt/homebrew/opt/go/bin

  go install golang.org/dl/go1.22.8@latest
  append_path $HOME/go/bin

  go1.22.8 download
else
  which mockgen
  if [[ $? -ne 0 ]]; then
    go install github.com/golang/mock/mockgen@latest
  fi

  which gopls
  if [[ $? -ne 0 ]]; then
    go install golang.org/x/tools/gopls@v0.16.2 # for go1.22
  fi
fi

# lrzsz  ## wezterm does not support rz/sz

# blade and cxx
brew install ninja glog protobuf googletest google-benchmark gperftools

# python
brew install uv

# https://github.com/sindresorhus/clipboard-cli
# echo xxx | clipboard, 这样 xxx 就在剪贴板中了, mac 有自带的 pbcopy & pbpaste
# npm install --global clipboard-cli

if [[ `uname` == "Darwin" ]]; then
  # 修改URI Schemes 默认的打开app
  # brew install swiftdefaultappsprefpane

  # 去掉各种设置密码的规则限制
  # https://apple.stackexchange.com/questions/337468/how-to-set-a-short-user-password-in-macos-mojave-and-later-10-14
  # pwpolicy -clearaccountpolicies
  
  # 开盖自动开机功能, 之后还需要重启下
  # sudo nvram AutoBoot=%00
  
  # ----------- settings defaults start -------------

  # enable tap-to-click for the trackpad and show the correct state in System Preferences
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
  defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1

  ## 禁止.DS_Store生成
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

  # show the path bar in the Finder
  defaults write com.apple.finder "ShowPathbar" -bool "true" && killall Finder

  # Apply the settings
  /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

  # ----------- settings defaults end -------------

  # https://github.com/buo/homebrew-cask-upgrade
  # suports `brew cu pin`
  brew tap buo/cask-upgrade
  
  brew install --cask raycast wezterm apifox
  brew install --cask logseq obsidian zotero netnewswire maczip adrive nutstore thunder iina

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
else
  brew install direnv tailspin bandwhich  # sudo bandwhich

  # 因为没有启动, 这个命令的exit status 是非0, 所以文件最后的exit 0 不能删掉
  # mysql 9.0 开始不允许使用固定密码登录, 先固定使用mysql 8 的最后一个版本
  brew install mysql@8.4
fi

exit 0

