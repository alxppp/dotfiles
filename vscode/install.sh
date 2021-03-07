#!/bin/sh

ln -s "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" /usr/local/bin/code

ln -s $ZSH/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

pkglist=$(cat $ZSH/vscode/package_list)
for i in ${pkglist[@]}; do
  code --install-extension $i
done
