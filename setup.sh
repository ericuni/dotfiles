#!/bin/zsh

current=`pwd`
dot="$HOME/git/dotfiles"

cd $HOME
rm -rf .vim && ln -sf $dot/vim .vim
ln -sf $dot/zsh/zshrc .zshrc
ln -sf $dot/rgignore .rgignore
ln -si $dot/gitconfig.`uname` .gitconfig
ln -sf $dot/rustfmt.toml .rustfmt.toml
ln -sf $dot/wezterm.lua .wezterm.lua

if [[ -d .nutstore ]]; then
  ln -sf $dot/nutstore/customExtRules.conf .nutstore/db/customExtRules.conf
fi

ln -sf $dot/fdignore .fdignore

[[ ! -d .config ]] && mkdir .config
cd .config || exit 1

# -L: soft link
if [[ -L nvim ]]; then
  rm nvim
fi
ln -sf $dot/vim/packer nvim
ln -sf $dot/zsh/starship.toml starship.toml
ln -sf $dot/pycodestyle pycodestyle

p=".docker"
[[ ! -d $p ]] && mkdir $p
cd $p
ln -sf $dot/docker/config.json config.json
cd -

cd $current

exit 0

