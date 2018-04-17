#!/bin/sh

cd $(dirname $0)

for dotfile in .?*
do
    if [ $dotfile != ".." ] && [ $dotfile != ".git" ] && [ $dotfile != ".gitmodules" ]
    then
        ln -Fis "$PWD/$dotfile" $HOME
    fi
done

mkdir -p ~/.vim/rc/
ln -s ~/dotfiles/dein.toml ~/.vim/rc/dein.toml
ln -s ~/dotfiles/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
