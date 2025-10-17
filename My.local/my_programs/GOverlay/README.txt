# Para perfeito funcionamento do MangoHud e GOverlay.

# Instale o MangoHud via Flatpak:
flatpak install org.freedesktop.Platform.VulkanLayer.MangoHud

# Rode esse comando para configurar a Steam, para aceitar o MangoHud.
flatpak override --user --env=MANGOHUD=1 com.valvesoftware.Steam

# Instale o Flatseal para monitorar com uma interface grafica as configuracoes feitas em aplicacoes Flatpak.
flatpak install flathub com.github.tchx84.Flatseal

# Abra o Flatseal va em "Todos os Aplicativos" e até a área "Filesystem" e adicione um "Novo Arquivo"
# Isso ira configurar para que todos os programas Flatpak tenha autorização para leitura do MangoHud
xdg-config/MangoHud:ro

# Caminho padrão do arquivo de configuralçao do MangoHud: "~/.config/MangoHud/MangoHud.conf"
# O GOverlay cria automaticamente esse arquivo.


