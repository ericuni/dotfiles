#!/bin/zsh

current=`pwd`
dot="$HOME/git/dotfiles"

cd $HOME
rm -rf .vim && ln -sf $dot/vim .vim
ln -sf $dot/zsh/zshrc .zshrc
ln -sf $dot/rgignore .rgignore
ln -si $dot/gitconfig .gitconfig

p=".config/nvim"
[[ ! -d $p ]] && mkdir -p $p
if [ ! -d .config/nvim ]; then
fi
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

