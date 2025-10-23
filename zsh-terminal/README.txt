# Instalar zsh:
sudo apt install zsh
sudo apt install curl
sudo apt install git

# Instalar fonte, extrair e mover para "~/.fonts":
cd ~/Downloads && curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/UbuntuMono.tar.xz

# Instalar Oh My Zsh:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Instalar Tema spaceship-prompt:
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1

ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# Instalar zsh-autosuggstons:
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Instalar zsh-syntax-highlighting:
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# Copiar o arquivo ".zshrc" e copia-lo para a pasta raiz do usuario "/home/{USER}". "~/.zshrc"
# "Ctrl + H" para Exibir diretorios ocultos.
# Não esqueca de alterar a fonte no Terminal, Fonte "UbuntuMono Nerd Font Mono".


