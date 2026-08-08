#!/bin/bash

# Desmonta o drive de forma forçada/preguiçosa
fusermount3 -uz /home/alex/.local/share/GoogleDrive

# Finaliza processos do rclone
killall rclone

# Remove a linha específica do arquivo de bookmarks (se existir)
# Usamos o delimitador | para evitar conflitos com as barras / da URL
sed -i '\|file:///home/alex/.local/share/GoogleDrive Google Drive|d' ~/.config/gtk-3.0/bookmarks

