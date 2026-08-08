#!/bin/bash

sudo -v
curl https://rclone.org/install.sh | sudo bash

rclone config create gdrive drive
# Estara aguardando eu definir a conta pelo navegador, enquanto isso o prograna aguarda...

SCHEMA_DIR="$HOME/.local/share/gnome-shell/extensions/custom-command-toggle@storageb.github.com/schemas"
SCHEMA="org.gnome.shell.extensions.custom-command-toggle"

export GSETTINGS_SCHEMA_DIR="$SCHEMA_DIR"

gsettings set "$SCHEMA" entryrow1-setting \
"$HOME/.local/my_scripts/gdrive-toggle/ON-gdrive.sh"

gsettings set "$SCHEMA" entryrow2-setting \
"$HOME/.local/my_scripts/gdrive-toggle/OFF-gdrive.sh"

gsettings set "$SCHEMA" entryrow3-setting \
"Google Drive"

gsettings set "$SCHEMA" entryrow4-setting \
"goa-panel-symbolic"

gsettings set "$SCHEMA" checkcommand1-setting \
'pgrep -l "rclone"'

gsettings set "$SCHEMA" initialtogglestate1-setting 2

gsettings set "$SCHEMA" runcommandatboot1-setting false
gsettings set "$SCHEMA" delaytime1-setting 3
gsettings set "$SCHEMA" checkcommanddelaytime1-setting 3

gsettings set "$SCHEMA" buttonclick1-setting 2

gsettings set "$SCHEMA" checkexitcode1-setting false
gsettings set "$SCHEMA" showindicator1-setting true
gsettings set "$SCHEMA" closemenu1-setting false
gsettings set "$SCHEMA" checkcommandsync1-setting true
gsettings set "$SCHEMA" checkcommandinterval1-setting 10

gsettings set "$SCHEMA" keybinding1-setting ""
gsettings set "$SCHEMA" enabled1-setting true
