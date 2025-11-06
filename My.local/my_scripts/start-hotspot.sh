#!/bin/bash
# Compartilhar internet da enp37s0 (Ethernet) para o hotspot wlx98254a5b2184

# Detecta interface com internet (geralmente a Ethernet ou VPN)
WAN_IF=$(ip route | grep default | awk '{print $5}' | head -n1)

# Detecta interface Wi-Fi (para o hotspot)
LAN_IF=$(nmcli -t -f DEVICE,TYPE device | grep -E "wifi|wi-fi|wireless" | cut -d: -f1 | grep -v "$WAN_IF" | head -n1)

echo "[INFO] Interface com internet (WAN): $WAN_IF"
echo "[INFO] Interface do hotspot (LAN):  $LAN_IF"

if [[ -z "$WAN_IF" ]]; then
    echo "[ERRO] Não foi possível detectar a interface com Internet (WAN)."
    exit 1
fi

if [[ -z "$LAN_IF" ]]; then
    echo "[ERRO] Não foi possível detectar a interface Wi-Fi (LAN)."
    nmcli device status
    exit 1
fi

echo "[INFO] Ativando encaminhamento de pacotes..."
sudo sysctl -w net.ipv4.ip_forward=1 > /dev/null
sudo sysctl -w net.ipv4.conf.all.forwarding=1 > /dev/null

echo "[INFO] Limpando regras antigas..."
sudo iptables -t nat -D POSTROUTING -o "$WAN_IF" -j MASQUERADE 2>/dev/null
sudo iptables -D FORWARD -i "$LAN_IF" -o "$WAN_IF" -j ACCEPT 2>/dev/null
sudo iptables -D FORWARD -i "$WAN_IF" -o "$LAN_IF" -m state --state RELATED,ESTABLISHED -j ACCEPT 2>/dev/null

echo "[INFO] Aplicando novas regras de NAT..."
sudo iptables -t nat -A POSTROUTING -o "$WAN_IF" -j MASQUERADE
sudo iptables -A FORWARD -i "$LAN_IF" -o "$WAN_IF" -j ACCEPT
sudo iptables -A FORWARD -i "$WAN_IF" -o "$LAN_IF" -m state --state RELATED,ESTABLISHED -j ACCEPT

echo "[OK] Internet deve estar compartilhada com clientes no hotspot!"

# Para manter após reiniciar:
sudo apt install iptables-persistent -y
sudo netfilter-persistent save
