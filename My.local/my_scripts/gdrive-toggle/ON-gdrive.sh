#! /bin/bash

rclone mount gdrive: /home/alex/.local/share/GoogleDrive --vfs-cache-mode full --volname "Google Drive" --daemon
echo "file:///home/alex/.local/share/GoogleDrive Google Drive" >> ~/.config/gtk-3.0/bookmarks

