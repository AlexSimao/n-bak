#!/usr/bin/env bash

set -e

# ==========================================
# Detecta o gerenciador de pacotes
# ==========================================
if command -v dnf >/dev/null 2>&1; then
    PKG="dnf"
    DISTRO="fedora"
elif command -v apt >/dev/null 2>&1; then
    PKG="apt"
    DISTRO="debian"
else
    echo "Distribuição não suportada."
    exit 1
fi

echo "Sistema detectado: $DISTRO"

# ==========================================
# Instalação dos pacotes
# ==========================================
if [ "$DISTRO" = "fedora" ]; then
    sudo dnf upgrade --refresh -y
    sudo dnf install --skip-unavailable -y \
        curl \
        git \
        zsh \
        wget \
        fastfetch \
        bat \
        flatpak \
        gnome-software \
        gnome-software-plugin-flatpak \
        malcontent-control

else
    sudo apt update

    sudo apt install -y \
        curl \
        git \
        zsh \
        wget \
        fastfetch \
        nala \
        bat \
        flatpak \
        gnome-software-plugin-flatpak \
        gnome-software-plugin-snap \
        malcontent-gui
fi

# ==========================================
# Instala fonte Nerd Font
# ==========================================
wget -cP /tmp \
https://github.com/ryanoasis/nerd-fonts/releases/latest/download/UbuntuMono.tar.xz

mkdir -p /tmp/UbuntuMono

tar -xf /tmp/UbuntuMono.tar.xz -C /tmp/UbuntuMono

mkdir -p "$HOME/.fonts"

cp -r /tmp/UbuntuMono/* "$HOME/.fonts/"

fc-cache -fv

# ==========================================
# Configura fonte do Ptyxis (caso exista)
# ==========================================
if gsettings list-schemas | grep -q org.gnome.Ptyxis; then
    gsettings set org.gnome.Ptyxis font-name "UbuntuMono Nerd Font Mono 12"
fi

# ==========================================
# Instala Oh My Zsh
# ==========================================
yes | sh -c \
"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

curl \
https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/templates/minimal.zshrc \
> "$HOME/.zshrc"

# Comenta a linha referente a plugins no .zshrc
sed -i '/plugins=(git)/s/^/# /' "$HOME/.zshrc"

# ==========================================
# Aliases
# ==========================================
cat <<'EOF' >> "$HOME/.zshrc"

alias ips="ip -c -br a"
alias mkdir="mkdir -pv"
alias sudo="sudo "
EOF

if [ "$DISTRO" = "debian" ]; then
cat <<'EOF' >> "$HOME/.zshrc"
alias apt="nala"
alias cat="batcat"
EOF

elif [ "$DISTRO" = "fedora" ]; then
cat <<'EOF' >> "$HOME/.zshrc"
alias cat="bat"
EOF

fi

# ==========================================
# Instala Zinit
# ==========================================
yes | bash -c \
"$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# ==========================================
# Configuração do Spaceship
# ==========================================
cat << 'EOF' >> "$HOME/.zshrc"

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  line_sep      # Line break
#  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
#SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light spaceship-prompt/spaceship-prompt

EOF

# ==========================================
# Define ZSH como shell padrão
# ==========================================
sudo chsh -s "$(command -v zsh)" "$USER"

dconf load /org/gnome/Ptyxis/ < <(curl -fsSL https://raw.githubusercontent.com/AlexSimao/n-bak/refs/heads/main/perfis_ptyxis.dconf)

# ==========================================
# LinuxToys
# ==========================================
curl -fsSL https://linux.toys/install.sh | bash

# ==========================================
# Flathub
# ==========================================
sudo flatpak remote-add --if-not-exists \
flathub \
https://dl.flathub.org/repo/flathub.flatpakrepo

# ==========================================
# Limpeza
# ==========================================
rm -rf /tmp/UbuntuMono /tmp/UbuntuMono.tar.xz

echo
echo "============================================="
echo " Reinicie a máquina para finalizar a instalação."
echo "============================================="
echo

exec "$SHELL"
