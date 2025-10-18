#!/bin/sh

sudo apt update
sudo apt upgrade
sudo apt autoremove
sudo apt install curl git zsh

cd $HOME/Downloads

curl -fsSL https://linux.toys/install.sh | sh
yes | LT_MANIFEST=1 linuxtoys /media/alex/n-bak/linuxtoys-manifest-list.txt





#sudo snap refresh
#sudo snap install intellij-idea-community --classic

#sudo rm -rf $HOME/Downloads/*


exec $SHELL
