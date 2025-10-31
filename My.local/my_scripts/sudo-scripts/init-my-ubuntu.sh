#!/bin/sh

sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt install curl git zsh fastfetch pulseaudio-utils -y

cd /tmp

git clone --depth=1 https://github.com/AlexSimao/n-bak.git /tmp/n-bak

# Instala o Discord .deb
curl -fsSL https://discord.com/api/download\?platform\=linux\&format\=deb -o /tmp/discord.deb
sudo apt install /tmp/discord.deb -y

# Roda os seguintes scripts do LinuxToys:
sudo linuxtoys-cli --install --script docker code swapfile btassist grub-btrfs steam lutris goverlay bottles flatseal vlc -y

# Install Mise
sudo sh -c "$(curl https://mise.run/zsh | sh)"

# Instala o SaveDesktop e importa pre-configurações salvas
sudo flatpak install flathub --system io.github.vikdevelop.SaveDesktop -y

/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=savedesktop io.github.vikdevelop.SaveDesktop --import-config /tmp/n-bak/*.sd.zip

# Remove pastas que podem existir
sudo rm -rf $HOME/.local/my_programs
sudo rm -rf $HOME/.local/my_scripts
# move tudo de My.local para $HOME/.local/
mkdir -p $HOME/.local
mv /tmp/n-bak/My.local/* $HOME/.local/

# Configura saida de audio combinada
mkdir -p $HOME/.config/autostart
chmod +x $HOME/.local/my_scripts/sink-audio/combined-sink.desktop
chmod +x $HOME/.local/my_scripts/sink-audio/combined-sink.sh 
ln -s $HOME/.local/my_scripts/sink-audio/combined-sink.desktop $HOME/.config/autostart/combined-sink.desktop

# Adiciona configurações do MangoHud
mkdir -p $HOME/.config/MangoHud
rm $HOME/.config/MangoHud/MangoHud.conf
mv /tmp/n-bak/MangoHud.conf $HOME/.config/MangoHud/MangoHud.conf

# Documentos uteis, não confidencial
mv /tmp/n-bak/Documentos-Curriculos $HOME/Documentos/

# Adiciona configurações padrões para apps Flatpak 
# flatpak override --user --filesystem=/media/alex/256gb-disk
flatpak override --user --filesystem=xdg-config/MangoHud:ro
flatpak override --user --filesystem=xdg-data/applications

# Verifica se tem alguama atualização de apps Snap e instala o IntelliJ
sudo snap refresh
sudo snap install intellij-idea-community --classic

# Altera o swappiness para 40 (SWAP só começa a ser usada quando a RAM atingir 60%)
sudo touch /etc/sysctl.conf
sudo echo 'vm.swappiness=40' > /etc/sysctl.conf
sudo sysctl -p

sudo btrfs subvolume create /.snapshots

sudo usermod -aG docker $USER

# Remove arquivos criados por esse script
sudo rm -rf /tmp/discord.deb /tmp/n-bak

echo '
Reinicie a maquina para finalizar a instalação.
'

exec $SHELL
