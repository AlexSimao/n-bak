#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt install curl git zsh pulseaudio-utils gnome-user-share -y

cd /tmp

git clone --depth=1 https://github.com/AlexSimao/n-bak.git /tmp/n-bak

# Instala o Discord .deb
# curl -fsSL https://discord.com/api/download\?platform\=linux\&format\=deb -o /tmp/discord.deb
# sudo apt install /tmp/discord.deb -y

# Reinstala o grub na partiçao /
sudo grub-install /dev/sda1

# Roda os seguintes scripts do LinuxToys:
sudo linuxtoys-cli --install --script swapfile docker steam lutris goverlay bottles flatseal -y

# Install Mise
sudo sh -c "$(curl https://mise.run/zsh | sh)"

# Ativa o Completion do mise para aparecer as opçẽes possiveis com o  "TAB"
# mise use --global npm maven node java@21 usage   
mise use --global usage
mise completion zsh  | sudo tee /usr/local/share/zsh/site-functions/_mise

# Instala o SaveDesktop e importa pre-configurações salvas
sudo flatpak install flathub --system io.github.vikdevelop.SaveDesktop -y

# /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=savedesktop io.github.vikdevelop.SaveDesktop --import-config /tmp/n-bak/*.sd.zip

flatpak run \
  --filesystem=/tmp/n-bak:ro \
  io.github.vikdevelop.SaveDesktop \
  --import-config /tmp/n-bak/*.sd.zip


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
flatpak override --user --env=MANGOHUD=1

# Verifica se tem alguama atualização de apps Snap e instala o IntelliJ
sudo snap refresh
# sudo snap install code --classic
# sudo snap install intellij-idea-community --classic

# Altera o swappiness para 30 (SWAP só começa a ser usada quando a RAM atingir 70%)
echo 'vm.swappiness=20'| sudo tee /etc/sysctl.d/7-swappiness.conf

sudo btrfs subvolume create /.snapshots

# Adiciona o usuario a grupo do Docker.
sudo usermod -aG docker $USER

# Mexendo em configurações do GRUB

# Pede para deixar o menu do grub visivel
sudo sed -i '/^GRUB_TIMEOUT_STYLE=hidden$/{
s/^/#/
a GRUB_TIMEOUT_STYLE=menu
}' /etc/default/grub

# Altera o Timeout para 15s
sudo sed -i 's/^GRUB_TIMEOUT=0$/GRUB_TIMEOUT=15/' /etc/default/grub

# Altera a resolução do grub para 1920x1080
sudo sed -i 's/^#\?GRUB_GFXMODE=.*/GRUB_GFXMODE=1920x1080/' /etc/default/grub

# Descomenta ou substitui se já existir a linha referente ao OS_PROBER
sudo sed -i 's/^#\?GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub

# Adiciona uma customizção personalizada ao GRUB.  Reconhece automatomamente pendrivers bootaveis do Batocera e Ventoy.
sudo tee -a /etc/grub.d/40_custom << 'EOF'

#menuentry "Instalar Windows (UEFI)" {
#    insmod part_gpt
#    insmod fat
#    search --no-floppy --set=root --label winboot
#    chainloader /efi/boot/bootx64.efi
#}

if search --no-floppy --label VTOYEFI --set=root ; then
menuentry "Ventoy.boot (UEFI)" {
    insmod part_gpt
    insmod fat
    
    search --no-floppy --set=root --label VTOYEFI
    chainloader /efi/boot/bootx64.efi
}
fi

if search --no-floppy --label BATOCERA --set=root ; then
menuentry "Batocera.linux (Legacy)" {
    insmod part_msdos
    insmod fat
    
    linux /boot/linux label=BATOCERA console=tty3 quiet loglevel=0
    initrd /boot/initrd.gz
}
fi
EOF
# Atualizando o GRUB para que as alterações sejam inseridas.
sudo update-grub

# Remove arquivos criados por esse script
sudo rm -rf /tmp/discord.deb /tmp/n-bak

echo '
=============================================
Reinicie a maquina para finalizar a instalação.
=============================================
'

exec $SHELL
