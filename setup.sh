#!/bin/zsh

current=`pwd`
dot="$HOME/git/dotfiles"

cd $HOME
rm -rf .vim && ln -sf $dot/vim .vim
ln -sf $dot/zsh/zshrc .zshrc
ln -sf $dot/rgignore .rgignore
ln -si $dot/gitconfig.$os .gitconfig
ln -sf $dot/rustfmt.toml .rustfmt.toml

p=".config/nvim"
[[ ! -d $p ]] && mkdir -p $p
cd $p
ln -sf $dot/vim/init.vim init.vim
ln -sf $dot/vim/coc-settings.json coc-settings.json
cd -

p=".docker"
[[ ! -d $p ]] && mkdir $p
cd $p
ln -sf $dot/docker/config.json config.json
cd -

cd $current

exit 0

