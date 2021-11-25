#!/bin/zsh

current=`pwd`
dot="$HOME/git/dotfiles"

cd $HOME
rm -rf .vim && ln -sf $dot/vim .vim
ln -sf $dot/zsh/zshrc .zshrc
ln -sf $dot/rgignore .rgignore
ln -si $dot/gitconfig .gitconfig

if [ ! -d .config/nvim ]; then
  mkdir -p .config/nvim
fi
cd .config/nvim
ln -sf $dot/vim/init.vim init.vim
ln -sf $dot/vim/coc-settings.json coc-settings.json

cd $current

exit 0

