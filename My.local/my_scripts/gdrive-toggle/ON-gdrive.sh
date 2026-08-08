#!/bin/bash

# Monta o Google Drive
rclone mount gdrive: /home/alex/.local/share/GoogleDrive --vfs-cache-mode full --volname "Google Drive" --daemon

# Define a linha do favorito
BOOKMARK_LINE="file:///home/alex/.local/share/GoogleDrive Google Drive"
BOOKMARK_FILE="$HOME/.config/gtk-3.0/bookmarks"

# Verifica se a linha já existe no arquivo antes de adicionar
if ! grep -xq "$BOOKMARK_LINE" "$BOOKMARK_FILE"; then
    echo "$BOOKMARK_LINE" >> "$BOOKMARK_FILE"
fi

