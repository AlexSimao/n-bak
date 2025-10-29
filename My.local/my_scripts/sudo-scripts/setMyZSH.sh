#!/bin/sh

# Instalar zsh:
sudo apt update && sudo apt install curl git zsh wget -y

# Instala a fonte, extrai e move a para "$HOME/.fonts":
# Alterar a fonte no Terminal para que não tenha icones quebrados, Fonte "UbuntuMono Nerd Font Mono"
wget -cP /tmp https://github.com/ryanoasis/nerd-fonts/releases/latest/download/UbuntuMono.tar.xz
cd /tmp && mkdir UbuntuMono
tar -xf UbuntuMono.tar.xz -C UbuntuMono
mkdir $HOME/.fonts
mv UbuntuMono $HOME/.fonts
fc-cache -fv

sleep 1

# Instalar Oh My Zsh sem mudar automaticamente para o shell
# export RUNZSH=no
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

sleep 1

# Cria Template do .zshrc na home do usuario
curl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/templates/zshrc.zsh-template > $HOME/.zshrc

sleep 1

# Instala o zinit para gerenciar plugins no ZSH
yes | bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

sleep 1

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

# Plugins para o ZSH
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting

# Tema do Spaceship
zinit light spaceship-prompt/spaceship-prompt
EOF

sleep 1

# Altera o Shell do osuario para o ZSH
sudo chsh -s $(which zsh) $(whoami)

# Installs mise and adds activation to ~/.zshrc
# sh -c "$(curl https://mise.run/$(basename "$SHELL") | sh)"
# sh -c "$(curl https://mise.run/zsh | sh)"

# Instala o LinuxToys
curl -fsSL https://linux.toys/install.sh | sh

# Configurando Flathub na maquina.
sudo apt install flatpak gnome-software-plugin-flatpak gnome-software-plugin-snap malcontent-gui -y

sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

sleep 1

# Remove tudo que foi instalado em /tmp
sudo rm -rf /tmp/UbuntuMono /tmp/UbuntuMono* linuxtoys*

echo '
Reinicie a maquina para finalizar a instalação.
'

# Quando rodar o script mantera o terminal interativo e visivel para o usuario
exec $SHELL

