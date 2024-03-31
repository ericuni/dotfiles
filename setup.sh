#!/bin/zsh

current=`pwd`
dot="$HOME/git/dotfiles"

cd $HOME
rm -rf .vim && ln -sf $dot/vim .vim
ln -sf $dot/zsh/zshrc .zshrc
ln -sf $dot/rgignore .rgignore
if [[ ! -z $os ]]; then
  ln -si $dot/gitconfig.$os .gitconfig
else
  ## set mac as default
  ln -si $dot/gitconfig.mac .gitconfig
fi
ln -sf $dot/rustfmt.toml .rustfmt.toml
ln -sf $dot/wezterm.lua .wezterm.lua

if [[ -d .nutstore ]]; then
  ln -sf $dot/nutstore/customExtRules.conf .nutstore/db/customExtRules.conf
fi

cd .config || exit 1
# -L: soft link
if [[ -L nvim ]]; then
  rm nvim
fi
ln -sf $dot/vim/lazyvim nvim

p=".docker"
[[ ! -d $p ]] && mkdir $p
cd $p
ln -sf $dot/docker/config.json config.json
cd -

cd $current

exit 0

