#!/bin/bash
# Script para reconectar fone QCY Melobuds ANC e ativar A2DP automaticamente

# MAC do seu dispositivo
BT_MAC="84:AC:60:E9:02:7C"
# Nome do card PulseAudio (substituindo ':' por '_')
CARD_NAME="bluez_card.${BT_MAC//:/_}"

echo "Reiniciando Bluetooth e PulseAudio..."
sudo systemctl restart bluetooth
pulseaudio -k
pulseaudio --start
sleep 2

echo "Reconectando dispositivo Bluetooth..."
bluetoothctl disconnect "$BT_MAC"
sleep 2
bluetoothctl connect "$BT_MAC"
sleep 5

# Tenta forçar o perfil A2DP
echo "Definindo perfil A2DP..."
pactl set-card-profile "$CARD_NAME" a2dp_sink

# Verifica se o perfil foi ativado
CURRENT_PROFILE=$(pactl list cards | grep -A20 "$CARD_NAME" | grep "Perfil ativo" | awk -F: '{print $2}' | xargs)
echo "Perfil atual do fone: $CURRENT_PROFILE"

if [[ "$CURRENT_PROFILE" == "a2dp_sink" ]]; then
    echo "✅ Perfil A2DP ativado com sucesso!"
else
    echo "⚠️ Não foi possível ativar A2DP. Tente reconectar manualmente."
fi

