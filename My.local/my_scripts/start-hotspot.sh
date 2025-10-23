#!/bin/bash
# Compartilhar internet da enp37s0 (Ethernet) para o hotspot wlx98254a5b2184

WAN_IF="enp37s0"       # Interface com internet
LAN_IF="wlx98254a5b2184" # Interface do hotspot

echo "[INFO] Ativando encaminhamento de pacotes..."
sudo sysctl -w net.ipv4.ip_forward=1 > /dev/null

echo "[INFO] Configurando regras de NAT..."
sudo iptables -t nat -A POSTROUTING -o "$WAN_IF" -j MASQUERADE

echo "[INFO] Permitindo encaminhamento entre $LAN_IF <-> $WAN_IF..."
sudo iptables -A FORWARD -i "$LAN_IF" -o "$WAN_IF" -j ACCEPT
sudo iptables -A FORWARD -i "$WAN_IF" -o "$LAN_IF" -m state --state RELATED,ESTABLISHED -j ACCEPT

echo "[OK] Internet deve estar compartilhada com clientes no hotspot!"

# Para manter após reiniciar:
# sudo apt install iptables-persistent -y
# sudo netfilter-persistent save
