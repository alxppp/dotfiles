#!/bin/sh

ln -s $ZSH/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s $ZSH/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

# pkglist=$(cat $ZSH/vscode/package_list)
# for i in ${pkglist[@]}; do
#   code --install-extension $i
# done
