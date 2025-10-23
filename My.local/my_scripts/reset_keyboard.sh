#!/bin/bash

# IDs do teclado
# Comando "lsusb" para descobrir dispositivos conectados por USB.
VENDOR_ID="1c4f"
PRODUCT_ID="0202"

# Procura o dispositivo pelo ID no sysfs
for device in /sys/bus/usb/devices/*; do
    if [[ -f "$device/idVendor" && -f "$device/idProduct" ]]; then
        if [[ "$(cat $device/idVendor)" == "$VENDOR_ID" && "$(cat $device/idProduct)" == "$PRODUCT_ID" ]]; then
            DEVICE_NAME=$(basename "$device")
            echo "Teclado encontrado em: $DEVICE_NAME"

            # Desativa
            echo -n "$DEVICE_NAME" | sudo tee /sys/bus/usb/drivers/usb/unbind
            sleep 2

            # Reativa
            echo -n "$DEVICE_NAME" | sudo tee /sys/bus/usb/drivers/usb/bind
            echo "Teclado reiniciado com sucesso."
            exit 0
        fi
    fi
done

echo "Teclado USB com ID $VENDOR_ID:$PRODUCT_ID não encontrado."
exit 1

# Para o Script funcionar perfeitamente,
# Digite no terminal "sudo visudo" e edite o arquivo "/etc/sudoers.tmp".
# Adicione essas duas linhas ao final do arquivo "/etc/sudoers.tmp":
# alex ALL=(ALL) NOPASSWD: /bin/echo
# alex ALL=(ALL) NOPASSWD: /usr/bin/tee


