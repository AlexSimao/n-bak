#! /bin/bash

fusermount3 -uz /home/alex/.local/share/GoogleDrive
killall rclone
sed -i '\|file:///home/alex/.local/share/GoogleDrive|d' ~/.config/gtk-3.0/bookmarks

