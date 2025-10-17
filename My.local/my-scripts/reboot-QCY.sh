#!/bin/bash

BT_MAC="84:AC:60:E9:02:7C"

# Reconecta o dispositivo
bluetoothctl disconnect "$BT_MAC"
sleep 2.5
bluetoothctl connect "$BT_MAC"
sleep 5

# chmod +x ~/.local/my-scripts/reboot-QCY.sh

# Define o perfil A2DP via pactl (se necessário)
# pactl set-card-profile bluez_card.${BT_MAC//:/_} a2dp_sink

