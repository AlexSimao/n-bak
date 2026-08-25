#!/usr/bin/env bash

# ==============================================================================
# Script de pós-instalação para Debian/Ubuntu e Fedora
#
# Autor: Alex Simão
#
# O script:
#   - Atualiza o sistema.
#   - Instala dependências básicas.
#   - Clona configurações pessoais.
#   - Instala programas através do LinuxToys.
#   - Configura o Mise.
#   - Restaura configurações do SaveDesktop.
#   - Configura áudio combinado.
#   - Configura MangoHud.
#   - Ajusta permissões do Docker.
#   - Personaliza o GRUB.
#
# ==============================================================================

set -e

# ==============================================================================
# Detecta a distribuição Linux
# ==============================================================================

if command -v dnf >/dev/null 2>&1; then
    DISTRO="fedora"

elif command -v apt >/dev/null 2>&1; then
    DISTRO="debian"

else
    echo "Distribuição Linux não suportada."
    exit 1
fi

echo "Sistema detectado: $DISTRO"

# ==============================================================================
# Atualiza o sistema e instala dependências
# ==============================================================================

if [ "$DISTRO" = "fedora" ]; then

    sudo dnf upgrade --refresh -y

    sudo dnf autoremove -y

    sudo dnf install -y \
        curl \
        git \
        zsh \
        pulseaudio-utils \
        gnome-user-share

else

    sudo apt update

    sudo apt upgrade -y

    sudo apt autoremove -y

    sudo apt install -y \
        curl \
        git \
        zsh \
        pulseaudio-utils \
        gnome-user-share

fi

# ==============================================================================
# Baixa arquivos de configuração
# ==============================================================================

cd /tmp

git clone --depth=1 \
https://github.com/AlexSimao/n-bak.git \
/tmp/n-bak

# ==============================================================================
# Instala programas utilizando o LinuxToys
# ==============================================================================

sudo linuxtoys \
    --install \
    --script docker steam bottles flatseal \
    -y

# ==============================================================================
# Instala o Mise
# ==============================================================================

sudo sh -c "$(curl https://mise.run/zsh | sh)"

# Habilita autocompletar no ZSH

mise use --global usage

sudo mkdir -p /usr/local/share/zsh/site-functions

mise completion zsh | sudo tee \
/usr/local/share/zsh/site-functions/_mise >/dev/null

# ==============================================================================
# Instala SaveDesktop
# ==============================================================================

sudo flatpak install flathub \
--system \
io.github.vikdevelop.SaveDesktop \
-y

# Importa backup do ambiente

flatpak run \
    --filesystem=/tmp/n-bak:ro \
    io.github.vikdevelop.SaveDesktop \
    --import-config /tmp/n-bak/*.sd.zip

# ==============================================================================
# Copia scripts pessoais
# ==============================================================================

rm -rf "$HOME/.local/my_programs"
rm -rf "$HOME/.local/my_scripts"

mkdir -p "$HOME/.local"

mv /tmp/n-bak/My.local/* \
"$HOME/.local/"

# ==============================================================================
# Configuração de áudio combinado
# ==============================================================================

mkdir -p "$HOME/.config/autostart"

chmod +x \
"$HOME/.local/my_scripts/sink-audio/combined-sink.desktop"

chmod +x \
"$HOME/.local/my_scripts/sink-audio/combined-sink.sh"

ln -sf \
"$HOME/.local/my_scripts/sink-audio/combined-sink.desktop" \
"$HOME/.config/autostart/combined-sink.desktop"

# ==============================================================================
# Configuração do MangoHud
# ==============================================================================

mkdir -p "$HOME/.config/MangoHud"

mv -f \
/tmp/n-bak/MangoHud.conf \
"$HOME/.config/MangoHud/MangoHud.conf"

# ==============================================================================
# Configura permissões padrão para Flatpak
# ==============================================================================

flatpak override --user \
--filesystem=xdg-config/MangoHud

flatpak override --user \
--filesystem=xdg-data/applications

flatpak override --user \
--env=MANGOHUD=1

# ==============================================================================
# Atualiza pacotes Snap (somente Debian/Ubuntu)
# ==============================================================================

if [ "$DISTRO" = "debian" ]; then

    sudo snap refresh

    # sudo snap install code --classic
    # sudo snap install intellij-idea-community --classic

fi

# ==============================================================================
# Adiciona usuário ao grupo Docker
# ==============================================================================

sudo usermod -aG docker "$USER"

# ==============================================================================
# Personalização do GRUB
# ==============================================================================

# Exibe o menu do GRUB

sudo sed -i '/^GRUB_TIMEOUT_STYLE=hidden$/{
s/^/#/
a GRUB_TIMEOUT_STYLE=menu
}' /etc/default/grub

# Timeout

sudo sed -i \
's/^GRUB_TIMEOUT=0$/GRUB_TIMEOUT=15/' \
/etc/default/grub

# Resolução

sudo sed -i \
's/^#\?GRUB_GFXMODE=.*/GRUB_GFXMODE=1920x1080/' \
/etc/default/grub

# Ativa o OS-Prober

sudo sed -i \
's/^#\?GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' \
/etc/default/grub

# ==============================================================================
# Adiciona entradas personalizadas ao GRUB
# ==============================================================================

sudo tee -a /etc/grub.d/40_custom >/dev/null <<'EOF'

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

# ==============================================================================
# Atualiza o GRUB
# ==============================================================================

if [ "$DISTRO" = "fedora" ]; then

    if [ -d /sys/firmware/efi ]; then
        sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
    else
        sudo grub2-mkconfig -o /boot/grub2/grub.cfg
    fi

else

    sudo update-grub

fi

# ==============================================================================
# Remove arquivos temporários
# ==============================================================================

rm -rf /tmp/n-bak

# ==============================================================================
# Finalização
# ==============================================================================

echo
echo "============================================="
echo " Reinicie a máquina para finalizar a instalação."
echo "============================================="
echo

exec "$SHELL"
