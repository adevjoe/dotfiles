#!/bin/bash

ZSHRC=~/.zshrc
VIMRC=~/.vimrc
DOTFILES=~/.dotfiles
sed -i '/source $HOME\/.dotfiles\/.source/d' $ZSHRC
sed -i '/source $HOME\/.dotfiles\/.vimrc/d' $VIMRC

rm -rf $DOTFILES || {
    printf "Error: Uninstall dotfiles failed\n"
    exit 1
}
printf "Uninstall dotfiles successful!\n"
