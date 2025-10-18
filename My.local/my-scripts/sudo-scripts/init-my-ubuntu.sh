#!/bin/sh

sudo apt update
sudo apt upgrade
sudo apt autoremove
sudo apt install curl git zsh fastfetch pulseaudio-utils -y

cd $HOME/Downloads

git clone --depth=1 https://github.com/AlexSimao/n-bak.git $HOME/Downloads/n-bak

# Baixa o manifest.txt com info dos apps que serao instalados pelo linuxtoys e os instala.
yes | LT_MANIFEST=1 linuxtoys $HOME/Downloads/n-bak/*manifest*.txt

# Instala o SaveDesktop e importa pre-configurações
/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=savedesktop io.github.vikdevelop.SaveDesktop --import-config $HOME/Downloads/n-bak/*.sd.zip

mkdir -p $HOME/.local
mv $HOME/Downloads/n-bak/My.local/* $HOME/.local/

mkdir -p $HOME/.config/autostart
ln -s $HOME/.local/my-scripts/sink-audio/combined-sink.desktop $HOME/.config/autostart/combined-sink.desktop

mkdir -p $HOME/.config/MangoHud
mv $HOME/Downloads/n-bak/MangoHud.conf $HOME/.config/MangoHud/MangoHud.conf

mv $HOME/Downloads/n-bak/Documentos-Curriculos $HOME/Documentos/



flatpak override --user --filesystem=/media/alex/"256 GB Disk"
flatpak override --user --filesystem=xdg-config/MangoHud:ro
flatpak override --user --filesystem=xdg-data/applications

sudo snap refresh
sudo snap install intellij-idea-community --classic

sudo echo 'vm.swappiness=40' >> /etc/sysctl.conf
sudo sysctl -p

#sudo rm -rf $HOME/Downloads/*


exec $SHELL
