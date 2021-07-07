#/bin/zsh
set -x

src=`pwd`
dst="~/Library/Application\ Support/Code/User"

# https://stackoverflow.com/questions/589149/bash-script-to-cd-to-directory-with-spaces-in-pathname/47617581
eval cd $dst
ln -sf $src/settings.json settings.json
ln -sf $src/keybindings.json keybindings.json
cd -

exit 0

