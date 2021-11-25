#!/bin/zsh

dot="$HOME/git/dotfiles"

cd $HOME
rm -rf .vim && ln -sf $dot/vim .vim
ln -sf $dot/zsh/zshrc .zshrc
ln -sf $dot/rgignore .rgignore
ln -si $dot/gitconfig .gitconfig

if [ ! -d .config/nvim ]; then
  mkdir -p .config/nvim
fi
ln -sf $dot/vim/init.vim .config/nvim/init.vim

cd -

exit 0

