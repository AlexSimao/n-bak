	Driver: module-alsa-card.c
	Módulo proprietário: 7
	Propriedades:
		alsa.card = "0"
		alsa.card_name = "HDA ATI HDMI"
		alsa.long_card_name = "HDA ATI HDMI at 0xfcb20000 irq 79"
		alsa.driver_name = "snd_hda_intel"
		device.bus_path = "pci-0000:12:00.1"
		sysfs.path = "/devices/pci0000:00/0000:00:01.1/0000:10:00.0/0000:11:00.0/0000:12:00.1/sound/card0"
		device.bus = "pci"
		device.vendor.id = "1002"
		device.vendor.name = "Advanced Micro Devices, Inc. [AMD/ATI]"
		device.product.id = "ab28"
		device.product.name = "Navi 21 HDMI Audio [Radeon RX 6800/6800 XT / 6900 XT]"
		device.string = "0"
		device.description = "Navi 21 HDMI Audio [Radeon RX 6800/6800 XT / 6900 XT]"
		module-udev-detect.discovered = "1"
		device.icon_name = "audio-card-pci"
	Perfis:
		output:hdmi-stereo: Saída Digital Stereo (HDMI) (destino: 1, fontes: 0, prioridade: 38668, disponível: sim)
		output:hdmi-stereo-extra1: Saída Digital Stereo (HDMI 2) (destino: 1, fontes: 0, prioridade: 5700, disponível: não)
		output:hdmi-surround-extra1: Saída Digital Surround 5.1 (HDMI 2) (destino: 1, fontes: 0, prioridade: 600, disponível: não)
		output:hdmi-surround71-extra1: Saída Digital Surround 7.1 (HDMI 2) (destino: 1, fontes: 0, prioridade: 600, disponível: não)
		output:hdmi-stereo-extra2: Saída Digital Stereo (HDMI 3) (destino: 1, fontes: 0, prioridade: 5700, disponível: não)
		output:hdmi-surround-extra2: Saída Digital Surround 5.1 (HDMI 3) (destino: 1, fontes: 0, prioridade: 600, disponível: não)
		output:hdmi-surround71-extra2: Saída Digital Surround 7.1 (HDMI 3) (destino: 1, fontes: 0, prioridade: 600, disponível: não)
		output:hdmi-stereo-extra3: Saída Digital Stereo (HDMI 4) (destino: 1, fontes: 0, prioridade: 5700, disponível: não)
		output:hdmi-surround-extra3: Saída Digital Surround 5.1 (HDMI 4) (destino: 1, fontes: 0, prioridade: 600, disponível: não)
		output:hdmi-surround71-extra3: Saída Digital Surround 7.1 (HDMI 4) (destino: 1, fontes: 0, prioridade: 600, disponível: não)
		output:hdmi-stereo-extra4: Saída Digital Stereo (HDMI 5) (destino: 1, fontes: 0, prioridade: 5700, disponível: não)
		output:hdmi-surround-extra4: Saída Digital Surround 5.1 (HDMI 5) (destino: 1, fontes: 0, prioridade: 600, disponível: não)
		output:hdmi-surround71-extra4: Saída Digital Surround 7.1 (HDMI 5) (destino: 1, fontes: 0, prioridade: 600, disponível: não)
		off: Desligado (destino: 0, fontes: 0, prioridade: 0, disponível: sim)
	Perfil ativo: output:hdmi-stereo
	Portas:
		hdmi-output-0: HDMI / DisplayPort (tipo: HDMI, prioridade: 5900, mudança da latência: 0 usec, disponível)
			Propriedades:
				device.icon_name = "video-display"
				device.product.name = "22B1WG5"
			Parte de perfil/perfis: output:hdmi-stereo
		hdmi-output-1: HDMI / DisplayPort 2 (tipo: HDMI, prioridade: 5800, mudança da latência: 0 usec, não disponível)
			Propriedades:
				device.icon_name = "video-display"
			Parte de perfil/perfis: output:hdmi-stereo-extra1, output:hdmi-surround-extra1, output:hdmi-surround71-extra1
		hdmi-output-2: HDMI / DisplayPort 3 (tipo: HDMI, prioridade: 5700, mudança da latência: 0 usec, não disponível)
			Propriedades:
				device.icon_name = "video-display"
			Parte de perfil/perfis: output:hdmi-stereo-extra2, output:hdmi-surround-extra2, output:hdmi-surround71-extra2
		hdmi-output-3: HDMI / DisplayPort 4 (tipo: HDMI, prioridade: 5600, mudança da latência: 0 usec, não disponível)
			Propriedades:
				device.icon_name = "video-display"
			Parte de perfil/perfis: output:hdmi-stereo-extra3, output:hdmi-surround-extra3, output:hdmi-surround71-extra3
		hdmi-output-4: HDMI / DisplayPort 5 (tipo: HDMI, prioridade: 5500, mudança da latência: 0 usec, não disponível)
			Propriedades:
				device.icon_name = "video-display"
			Parte de perfil/perfis: output:hdmi-stereo-extra4, output:hdmi-surround-extra4, output:hdmi-surround71-extra4
Placa #1
	Nome: alsa_card.pci-0000_30_00.1
	Driver: module-alsa-card.c
	Módulo proprietário: 8
	Propriedades:
		alsa.card = "1"
		alsa.card_name = "HD-Audio Generic"
		alsa.long_card_name = "HD-Audio Generic at 0xfc988000 irq 80"
		alsa.driver_name = "snd_hda_intel"
		device.bus_path = "pci-0000:30:00.1"
		sysfs.path = "/devices/pci0000:00/0000:00:08.1/0000:30:00.1/sound/card1"
		device.bus = "pci"
		device.vendor.id = "1002"
		device.vendor.name = "Advanced Micro Devices, Inc. [AMD/ATI]"
		device.product.id = "1637"
		device.product.name = "Renoir Radeon High Definition Audio Controller"
		device.string = "1"
		device.description = "Renoir Radeon High Definition Audio Controller"
		module-udev-detect.discovered = "1"
		device.icon_name = "audio-card-pci"
	Perfis:
		output:hdmi-stereo: Saída Digital Stereo (HDMI) (destino: 1, fontes: 0, prioridade: 5900, disponível: não)
		output:hdmi-surround: Saída Digital Surround 5.1 (HDMI) (destino: 1, fontes: 0, prioridade: 800, disponível: não)
		output:hdmi-surround71: Saída Digital Surround 7.1 (HDMI) (destino: 1, fontes: 0, prioridade: 800, disponível: não)
		output:hdmi-stereo-extra1: Saída Digital Stereo (HDMI 2) (destino: 1, fontes: 0, prioridade: 5700, disponível: não)
		output:hdmi-surround-extra1: Saída Digital Surround 5.1 (HDMI 2) (destino: 1, fontes: 0, prioridade: 600, disponível: não)
		output:hdmi-surround71-extra1: Saída Digital Surround 7.1 (HDMI 2) (destino: 1, fontes: 0, prioridade: 600, disponível: não)
		off: Desligado (destino: 0, fontes: 0, prioridade: 0, disponível: sim)
	Perfil ativo: off
	Portas:
		hdmi-output-0: HDMI / DisplayPort (tipo: HDMI, prioridade: 5900, mudança da latência: 0 usec, não disponível)
			Propriedades:
				device.icon_name = "video-display"
			Parte de perfil/perfis: output:hdmi-stereo, output:hdmi-surround, output:hdmi-surround71
		hdmi-output-1: HDMI / DisplayPort 2 (tipo: HDMI, prioridade: 5800, mudança da latência: 0 usec, não disponível)
			Propriedades:
				device.icon_name = "video-display"
			Parte de perfil/perfis: output:hdmi-stereo-extra1, output:hdmi-surround-extra1, output:hdmi-surround71-extra1
Placa #2
	Nome: alsa_card.pci-0000_30_00.6
	Driver: module-alsa-card.c
	Módulo proprietário: 9
	Propriedades:
		alsa.card = "2"
		alsa.card_name = "HD-Audio Generic"
		alsa.long_card_name = "HD-Audio Generic at 0xfc980000 irq 81"
		alsa.driver_name = "snd_hda_intel"
		device.bus_path = "pci-0000:30:00.6"
		sysfs.path = "/devices/pci0000:00/0000:00:08.1/0000:30:00.6/sound/card2"
		device.bus = "pci"
		device.vendor.id = "1022"
		device.vendor.name = "Advanced Micro Devices, Inc. [AMD]"
		device.product.id = "15e3"
		device.product.name = "Family 17h (Models 10h-1fh) HD Audio Controller"
		device.string = "2"
		device.description = "Family 17h (Models 10h-1fh) HD Audio Controller"
		module-udev-detect.discovered = "1"
		device.icon_name = "audio-card-pci"
	Perfis:
		input:analog-stereo: Entrada Estéreo analógico (destino: 0, fontes: 1, prioridade: 65, disponível: não)
		output:analog-stereo: Saída Estéreo analógico (destino: 1, fontes: 0, prioridade: 6500, disponível: não)
		output:analog-stereo+input:analog-stereo: Duplex estéreo analógico (destino: 1, fontes: 1, prioridade: 6565, disponível: não)
		off: Desligado (destino: 0, fontes: 0, prioridade: 0, disponível: sim)
	Perfil ativo: off
	Portas:
		analog-input-front-mic: Front Microphone (tipo: Mic, prioridade: 8500, mudança da latência: 0 usec, não disponível)
			Propriedades:
				device.icon_name = "audio-input-microphone"
			Parte de perfil/perfis: input:analog-stereo, output:analog-stereo+input:analog-stereo
		analog-input-rear-mic: Rear Microphone (tipo: Mic, prioridade: 8200, mudança da latência: 0 usec, não disponível)
			Propriedades:
				device.icon_name = "audio-input-microphone"
			Parte de perfil/perfis: input:analog-stereo, output:analog-stereo+input:analog-stereo
		analog-input-linein: Line In (tipo: Linha, prioridade: 8100, mudança da latência: 0 usec, não disponível)
			Parte de perfil/perfis: input:analog-stereo, output:analog-stereo+input:analog-stereo
		analog-output-lineout: Line Out (tipo: Linha, prioridade: 9000, mudança da latência: 0 usec, não disponível)
			Parte de perfil/perfis: output:analog-stereo, output:analog-stereo+input:analog-stereo
		analog-output-headphones: Headphones (tipo: Fones de ouvido, prioridade: 9900, mudança da latência: 0 usec, não disponível)
			Propriedades:
				device.icon_name = "audio-headphones"
			Parte de perfil/perfis: output:analog-stereo, output:analog-stereo+input:analog-stereo
alex@alex-pc:~/.config/systemd/user$ 
pactl list cards short
pactl list cards
pactl list cards short
pactl list cards
systemctl --user daemon-reexec
systemctl --user daemon-reload
systemctl --user restart monitor-qcy.service
systemctl --user status monitor-qcy.service
chmod +x ~/.config/systemd/scripts/switch-audio.sh
systemctl --user daemon-reexec
systemctl --user daemon-reload
systemctl --user enable --now bluetooth-audio.service
systemctl --user daemon-reload
systemctl --user restart bluetooth-audio.service
systemctl --user status bluetooth-audio.service
systemctl --user daemon-reload
systemctl --user restart bluetooth-audio.service
systemctl --user status bluetooth-audio.service
systemctl --user daemon-reload
systemctl --user restart bluetooth-audio.service
systemctl --user status bluetooth-audio.service
systemctl --user daemon-reexec
systemctl --user status bluetooth-audio.service
systemctl --user status monitor-qcy.service
DEVICE="bluez_card.84_AC_60_E9_02_7C"
PROFILE="a2dp_sink"
BT_MAC="84:AC:60:E9:02:7C"
# Aguarda o dispositivo ficar visível
while ! pactl list cards short | grep -q "$DEVICE"; do     sleep 1; done
# Troca o perfil de áudio
pactl set-card-profile "$DEVICE" "$PROFILE"
# Verifica se o dispositivo já está conectado
IS_CONNECTED=$(echo -e "info $BT_MAC" | bluetoothctl | grep -i "Connected: yes")
if [ -n "$IS_CONNECTED" ]; then
    echo -e "disconnect $BT_MAC" | bluetoothctl;     sleep 3; fi
# Tenta conectar novamente
echo -e "connect $BT_MAC" | bluetoothctl
sleep 5
# Aguarda o sink aparecer no PulseAudio
for i in {1..10}; do     SINK=$(pactl list short sinks | grep -i "$DEVICE" | awk '{print $2}');     if [ -n "$SINK" ]; then         break;     fi;     sleep 1; done
# Define como 
systemctl --user daemon-reload
systemctl --user restart bluetooth-audio.service
systemctl --user status bluetooth-audio.service
ps aux | grep switch-audio.sh
systemctl --user status bluetooth-audio.service
ps aux | grep -E 'bluetooth|switch-audio'
pkill -f switch-audio.sh
ps aux | grep -E 'bluetooth|switch-audio'
systemctl --user status bluetooth-audio.service
systemctl --user daemon-reload
systemctl --user restart bluetooth-audio.service
systemctl --user status bluetooth-audio.service
systemctl --user daemon-reexec
systemctl --user daemon-reload
systemctl --user restart bluetooth-audio.service
systemctl --user daemon-reexec
systemctl --user daemon-reload
systemctl --user restart bluetooth-audio.service
systemctl --user daemon-reload
systemctl --user restart bluetooth-audio.service
systemctl --user status bluetooth-audio.service
systemctl --user daemon-reload
systemctl --user restart bluetooth-audio.service
systemctl --user status bluetooth-audio.service
systemctl --user daemon-reload
systemctl --user restart bluetooth-audio.service
systemctl --user daemon-reload
systemctl --user restart bluetooth-audio.service
ps aux | grep -E 'bluetooth|switch-audio'
pkill -f switch-audio.sh
systemctl --user daemon-reexec
systemctl --user daemon-reload
systemctl --user restart bluetooth-audio.service
systemctl --user daemon-reexec
systemctl --user daemon-reload
systemctl --user restart bluetooth-audio.service
systemctl --user daemon-reexec
systemctl --user daemon-reload
systemctl --user restart bluetooth-audio.service
journalctl --user-unit=bluetooth-audio.service -e
sudo systemctl restart bluetooth
pulseaudio -k && pulseaudio --start
systemctl --user restart pipewire pipewire-pulse wireplumber
bluetoothctl
systemctl --user daemon-reexec
systemctl --user daemon-reload
systemctl --user restart bluetooth-audio.service
bluetoothctl
sudo apt install --reinstall bluez
sudo systemctl restart bluetooth
sudo apt install --reinstall bluez
sudo systemctl restart bluetooth
dmesg | grep -i blue
rfkill list
rfkill unblock bluetooth
rfkill list
bluetoothctl show
pactl list cards | grep -A20 bluez
pactl set-card-profile bluez_card.84_AC_60_E9_02_7C a2dp_sink
pactl list short sinks
paplay /usr/share/sounds/alsa/Front_Center.wav
pactl list sinks | grep -A15 bluez | grep Mute
pulseaudio --start
pactl list cards
pactl list sinks
paplay /usr/share/sounds/alsa/Front_Center.wav
ps aux | grep pulseaudio
rm -r ~/.config/pulse
rm -r ~/.pulse
pulseaudio --kill
pulseaudio --start
ls /run/user/1000/pulse/native
export PULSE_RUNTIME_PATH="/run/user/1000/pulse"
export PULSE_SERVER="unix:/run/user/1000/pulse/native"
pactl info
pulseaudio --kill
systemctl --user restart pulseaudio.service
pactl info
systemctl --user daemon-reload
systemctl --user restart pulseaudio.service
pactl info
systemctl --user daemon-reload
systemctl --user restart bluetooth-audio.service
systemctl --user status bluetooth-audio.service
systemctl --user daemon-reload
systemctl --user restart bluetooth-audio.service
systemctl --user status bluetooth-audio.service
systemctl --user daemon-reload
systemctl --user status bluetooth-audio.service
htop
blueman
blueman-manager
steam
sudo apt purge steam
sudo apt autoremove
sudo rm -rf
sudo rm -rf ~/.steam
steam
apt unstall steam
apt remove steam
sudo apt remove steam
sudo apt purge steam
sudo apt autoremove
sudo apt purge steam
sudo rm -rf ~/.steam
steam
sudo snap install steam
steam
lsb_release -a
sudo apt update && sudo apt upgrade -y
sudo add-apt-repository ppa:kisak/kisak-mesa
sudo apt update
sudo apt upgrade -y
lspci -k | grep -EA3 'VGA|3D'
vulkaninfo | grep deviceName
./mangohud-setup.sh install
apt show mangohud
mangohud
flatpak install org.freedesktop.Platform.VulkanLayer.MangoHud
flatpak override --user --env=MANGOHUD=1 com.valvesoftware.Steam
apt list goverlay
apt show goverlay
sudo apt-get update
wget https://github.com/davidbannon/libqt6pas/releases/download/v6.2.8/libqt6pas6_6.2.8-1_amd64.deb
sudo dpkg -i libqt6pas6_6.2.8-1_amd64.deb
tar -zxvf goverlay*.tar.gz
./goverlay
sudo apt-get update
wget https://github.com/davidbannon/libqt6pas/releases/download/v6.2.8/libqt6pas6_6.2.8-1_amd64.deb
sudo dpkg -i libqt6pas6_6.2.8-1_amd64.deb
tar -zxvf goverlay*.tar.gz
./goverlay
sudo apt-get update
wget https://github.com/davidbannon/libqt6pas/releases/download/v6.2.8/libqt6pas6_6.2.8-1_amd64.deb
sudo dpkg -i libqt6pas6_6.2.8-1_amd64.deb
tar -zxvf goverlay*.tar.gz
./goverlay
sudo apt-get update
wget https://github.com/davidbannon/libqt6pas/releases/download/v6.2.8/libqt6pas6_6.2.8-1_amd64.deb
sudo dpkg -i libqt6pas6_6.2.8-1_amd64.deb
tar -zxvf goverlay*.tar.gz
./goverlay
sudo apt-get update
wget https://github.com/davidbannon/libqt6pas/releases/download/v6.2.8/libqt6pas6_6.2.8-1_amd64.deb
sudo dpkg -i libqt6pas6_6.2.8-1_amd64.deb
tar -zxvf goverlay*.tar.xz
./goverlay
nano teste.txt
cat teste.txt
nano teste.txt
cat teste.txt
exit
/home/alex/.local/my_programs/GOverlay/GOverlay-git-anylinux-x86_64.AppImage
flatpak install mangohud
ps aux | grep -i steam
steam -clearbeta
flatpak run com.valvesoftware.Steam -clearbeta
blueman-maneger
blueman-manager
blueman-manager -h
blueman-manager --syslog
blueman-manager --log
blueman-manager --loglevel
blueman-manager --loglevel LEVEL
blueman-manager turn-of
iotop
ps
ps blueman-manager
strace
strace blueman-manager
top
pulseaudio
top blueman-manager
top -h
top --help
htop
ls
cd document
cd Document
cd /Document
cd /Documentos
strace -p <PID> -f -t -o log.txt blueman-manager
ps aux | grep blueman-manager
strace -p 49142 -f -t -o log.txt blueman-manager
bluetooth
ps aux | grep bluetoothctl
strace -p 50272 -f -t -o log.txt bluetoothctl
ps aux | grep pactl
strace -p 50515 -f -t -o log.txt pactl
pactl
pactl set-card-profile bluez_card.84_AC_60_E9_02_7C a2dp_sink
strace -p 50515 -f -t -o log.txt pactl
strace -p 18904 -f -t -o log.txt pactl
history
watch -n 1 "df -h"
blueman-applet
blueman-applet -h
blueman
/usr/bin/canberra-gtk-play --id="desktop-login" --description="GNOME Login"
pasystray
sudo apt install pasystray
apt --fix-broken install
pasystray
sudo apt remove pasystray
sudo apt autoremove
nano reboot-QCY.sh
chmod reboot-QCY.sh
chmod +x reboot-QCY.sh
chmod +x ~/.local/my-scripts/reboot-QCY.sh
chmod -h
chmod --help
chmod +x --help
chmod +x ~/.local/my-scripts/reboot-QCY.sh
reboot-QCY
reboot-QCY.sh
~/.local/my-scripts/reboot-QCY.sh
Exec=~/.local/my-scripts/reboot-QCY.sh
run ~/.local/my-scripts/reboot-QCY.sh
command=~/.local/my-scripts/reboot-QCY.sh
command
Exec
nano ~/.local/my-scripts/reboot-QCY.desktop
chmod +x ~/.local/my-scripts/reboot-QCY.desktop
chmod +x /home/alex/.local/my-scripts/reboot-QCY.sh
chmod +x ~/.local/share/applications/reboot-QCY.desktop
mv ~/.local/my-scripts/reboot-QCY.desktop ~/.local/share/applications/
chmod +x /home/alex/.local/my-scripts/reboot-QCY.sh
chmod +x ~/.local/share/applications/reboot-QCY.desktop
/home/alex/.local/my-scripts/reboot-QCY.sh
gtk-launch reboot-QCY
gtk-launch
gtk-launch --help
gtk-launch reboot-QCY
reboot-QCY.desktop
gtk-launch reboot-QCY
~/.local/my-scripts/reboot-QCY.sh
/~/.local/my-scripts/reboot-QCY.sh
cd .local
~/.local/my-scripts/reboot-QCY.sh
/home/alex/.local/my-scripts/reboot-QCY.sh
sudo su
gnome-session-quit --suspend
gnome-session-quit
shutdown -s
shutdown -s now
sudo shutdown -s now
sudo shutdown -h
sudo shutdown -c
suspend
gnome-session
top
gnome-session-quit
gnome-session -h
gnome-session --systemd
gnome-session -h
gnome-session --builtin
gnome-session-quit -h
gnome-session-quit --no-prompt
gnome-session-quit -h
gnome-session-quit --reboot
com.valvesoftware.Steam
/usr/bin/flatpak run --branch=stable --arch=x86_64 com.valvesoftware.Steam "$@"
chmod +x metadata
flatpak install flathub com.valvesoftware.Steam
sudo apt remove steam
sudo apt autoremove
cd /media/alex/256 GB Disk/
cd /media/alex/'256 GB Disk'/
steam
flatpak run steam
sudo flatpak override --filesystem=/media com.valvesoftware.Steam
programs
program
cat /etc/shells
/usr/bin/dash
apt list zsh
apt search zsh
sudo apt install zsh
sh
ps
cat /etc/shells
chsh /bin/zsh
chsh
ps
chsh
chsh usr/bin/zsh
sudo chsh usr/bin/zsh
cat /etc/shells
ps
zsh
ps
cat /etc/shells
chsh
ps
cat /etc/pssswd
cat /etc/passwd
zsh
chsh -s /bin/zsh
ps
curl
curl -h
apt list git
apt show git
add-apt-repository ppa:git-core/ppa
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt upgrade
apt list git
apt show git
apt show git -a
sudo apt install git
list
git -v
mvn
sudo apt install maven
mvn
pwd
cd ~
pwd
pwd
docker ps
sudo apt update
sudo apt upgrade
neofatch
sudo apt install neofetch
neofetch
btrfs-assistant
sudo apt install btrfs-assistant
apt search btrfs-ass
btrfs-assistant
sudo btrfs-assistant
apt search btrfs
apt search btrfs-
sudo apt list --installed | grep btrfs
btrfs-progs
sudo apt install flatpak
sudo apt install gnome-software
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo apt install gnome-software
sudo apt install gnome-software-plugin-snap
sudo apt install zram-config
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo --system
livre -h
free -h
flatpak remote-add flathub https://dl.flathub.org/repo/flathub.flatpakrepo --system
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo --system
[200~sudo apt install flatpak
sudo apt install flatpak |    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flathub.repo
sudo apt install gnome-software
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo --system
zsh
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo apt install curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo apt instal git
sudo apt install git
git --version
apt-get install git
sudo apt-get install git
git --version
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s /usr/bin/zsh
neofetch
sudo chsh -s /usr/bin/zsh
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
sudo git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
sudo git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
sudo ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
sudo git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
sudo ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sudo add-apt-repository ppa:papirus/papirus
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo apt install zram-config 
sudo apt install zram-config
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo --system
sudo apt update
sudo apt upgrade
sudo reboot
sudo apt install git cmake fonts-noto qt6-base-dev qt6-base-dev-tools g++ libbtrfs-dev libbtrfsutil-dev pkexec qt6-svg-dev qt6-tools-dev
cmake -B build -S . -DCMAKE_INSTALL_PREFIX=/usr
cmake -B build -S . -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE='Release'
make -C build
sudo make -C build install
sudo apt install snapper
sudo reboot
alex@alex-pc:~$ 
sudo apt update
sudo apt upgrade
btrfs-assistant
btrfs-assistant -h
btrfs-assistant -l
sudo btrfs-assistant -l
hello
sudo apt install ./linuxtoys_5.1.5-1_amd64.deb 
ssh alex@192.168.15.11
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
zsh
flatpak
btrfs-assistent
sudo apt install curl git zram-config
git -v
btrfs
btrfs-assistent
flatpak 
sudo apt install zsh
chsh
zsh
w
ls
w
docker ps
zsh
sudo ls
sudo chsh -s $(which bash) $(whoami)  
sudo ls
sudo chsh -s $(which zsh) $(whoami)  
ls
exit
