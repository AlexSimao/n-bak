#!/bin/sh

sudo apt update
sudo apt upgrade
sudo apt autoremove

cd $HOME/Downloads


#ID="1j5gzq3cNY3NiDpCX1OtpH77yZP-Dfu8l"
#curl -L "https://drive.google.com/uc?export=download&id=${ID}"

sudo snap refresh
sudo snap install intellij-idea-community --classic

sudo rm -rf $HOME/Downloads/*


exec $SHELL
