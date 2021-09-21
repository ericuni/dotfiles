#!/bin/zsh

dot="git/dotfiles"

cd ~
rm -rf .vim && ln -sf $dot/vim .vim
ln -sf $dot/zsh/zshrc .zshrc
ln -sf $dot/rgignore .rgignore
ln -si $dot/gitconfig .gitconfig
cd -

exit 0

