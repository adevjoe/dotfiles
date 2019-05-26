#!/bin/bash

ZSHRC=~/.zshrc
VIMRC=~/.vimrc
ST=~/.st
sed -i '/source $HOME\/.st\/.source/d' $ZSHRC
sed -i '/source $HOME\/.st\/.vimrc/d' $VIMRC

rm -rf $ST || {
    printf "Error: Uninstall shell tool failed\n"
    exit 1
}
printf "Uninstall shell tool successful!\n"