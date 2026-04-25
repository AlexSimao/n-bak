#!/usr/bin/env bash
set -euo pipefail

# 1. Detecção Automática
DISK=$(findmnt -no SOURCE / | sed 's/\[.*\]//')
ROOT_UUID=$(sudo blkid -p -s UUID -o value "$DISK")

# Detecta o disco da HOME (Cenário A: Partição separada)
DISK_HOME=$(findmnt -no SOURCE /home | sed 's/\[.*\]//')
HOME_UUID=$(sudo blkid -p -s UUID -o value "$DISK_HOME")

MNT="/mnt/btrfs_root"
MNT_H="/mnt/btrfs_home"

echo "==> Verificando Btrfs..."
findmnt -n -o FSTYPE / | grep -q btrfs || { echo "Erro: Não é Btrfs"; exit 1; }

# 2. Instalando e Configurando Snapper
echo "==> Instalando ferramentas e configurando Snapper..."
sudo apt update && sudo linuxtoys-cli --install --script grub-btrfs -y

# Cria configurações para Root e Home
sudo snapper -c root create-config / || true
sudo snapper -c home create-config /home || true
sudo snapper -c root set-config "ALLOW_GROUPS=sudo" "SYNC_ACL=yes"
sudo snapper -c home set-config "ALLOW_GROUPS=sudo" "SYNC_ACL=yes"

# 3. Montagem dos Discos (subvolid=5)
sudo mkdir -p "$MNT" "$MNT_H"
sudo mount -o subvolid=5 "$DISK" "$MNT"
sudo mount -o subvolid=5 "$DISK_HOME" "$MNT_H"

# --- SEÇÃO @ (ROOT) ---
if ! btrfs subvolume list "$MNT" | grep -q "path @$"; then
    echo "  ⚠️  Criando subvolume @..."
    sudo btrfs subvolume snapshot "$MNT" "$MNT/@"
fi

# --- SEÇÃO .SNAPSHOTS (ROOT) ---
if ! btrfs subvolume list "$MNT" | grep -q "path .snapshots$"; then
    echo "  -> Criando subvolume /.snapshots no Disco Root..."
    sudo umount /.snapshots 2>/dev/null || true
    [ -d "/.snapshots" ] && sudo rm -rf /.snapshots
    sudo btrfs subvolume create "$MNT/.snapshots"
fi

# --- SEÇÃO @home (HOME) ---
if ! btrfs subvolume list "$MNT_H" | grep -q "path @home$"; then
    echo "  ⚠️  Organizando subvolume @home..."
    sudo btrfs subvolume create "$MNT_H/@home"
    find "$MNT_H" -maxdepth 1 -not -name "@home" -not -name "." -not -name ".." -not -name ".snapshots" -exec mv {} "$MNT_H/@home/" \;
    echo "  ✅ @home organizado."
fi

# --- SEÇÃO .SNAPSHOTS (HOME) ---
# Verifica se existe o subvolume de snapshots na partição da HOME
if ! btrfs subvolume list "$MNT_H" | grep -q "path .snapshots$"; then
    echo "  -> Criando subvolume /home/.snapshots no Disco Home..."
    # O Snapper cria a pasta, mas para ser Btrfs de verdade (eficiente), criamos como subvolume
    sudo umount /home/.snapshots 2>/dev/null || true
    [ -d "/home/.snapshots" ] && sudo rm -rf /home/.snapshots
    sudo btrfs subvolume create "$MNT_H/.snapshots"
fi

# 4. Ajustando FSTAB
echo "==> Ajustando /etc/fstab..."
# Limpa entradas antigas específicas para evitar duplicidade
sudo sed -i '\|^[^#].* / btrfs|d' /etc/fstab
sudo sed -i '\|^[^#].* /home btrfs|d' /etc/fstab
sudo sed -i '\|^[^#].* /.snapshots|d' /etc/fstab
sudo sed -i '\|^[^#].* /home/.snapshots|d' /etc/fstab

# Montagens Root
echo "UUID=$ROOT_UUID / btrfs subvol=@,defaults,noatime,compress=zstd 0 1" | sudo tee -a /etc/fstab
echo "UUID=$ROOT_UUID /.snapshots btrfs subvol=.snapshots,defaults,noatime,compress=zstd 0 0" | sudo tee -a /etc/fstab

echo "UUID=$HOME_UUID /home btrfs subvol=@home,defaults,noatime,compress=zstd 0 0" | sudo tee -a /etc/fstab
echo "UUID=$HOME_UUID /home/.snapshots btrfs subvol=.snapshots,defaults,noatime,compress=zstd 0 0" | sudo tee -a /etc/fstab

# 5. Scripts de Rollback (Root e Home)
# --- ROOT ---
echo "==> Criando comando 'btrfs-rollback'..."
cat << 'EOF' | sudo tee /usr/local/bin/btrfs-rollback
#!/bin/bash
if [ -z "$1" ]; then
    echo "Uso: sudo btrfs-rollback <ID_DO_SNAPSHOT>"
    exit 1
fi
ID=$1
DISK=$(findmnt -no SOURCE / | sed 's/\[.*\]//')
MNT="/mnt/reparo_btrfs"
sudo mkdir -p $MNT
sudo mount -o subvolid=5 $DISK $MNT

echo "Substituindo @ atual pelo snapshot $ID..."
# 1. Renomeia o atual para backup
sudo mv $MNT/@ $MNT/@_antigo_$(date +%Y-%m-%d_%H:%M:%S)

# 2. Cria o novo @ a partir do snapshot
sudo btrfs subvolume snapshot $MNT/.snapshots/$ID/snapshot $MNT/@

# 3. O PULO DO GATO: Atualiza o subvolume padrão para o novo @
# Isso permite que você delete os subvolumes antigos depois
NEW_ID=$(btrfs subvolume list $MNT | grep "path @$" | awk '{print $2}')
sudo btrfs subvolume set-default $NEW_ID $MNT

sudo umount $MNT
echo "Pronto! O subvolume padrão agora é o novo @ (ID: $NEW_ID)."
echo "Reinicie para aplicar."
EOF
sudo chmod +x /usr/local/bin/btrfs-rollback

# --- HOME ---
echo "==> Criando comando 'btrfs-rollback-home'..."
cat << 'EOF' | sudo tee /usr/local/bin/btrfs-rollback-home
#!/bin/bash
# ==========================================================
# SCRIPT DE ROLLBACK PARA /HOME (SUBVOLUME @home)
# ==========================================================

if [ -z "$1" ]; then
    echo "Uso: sudo btrfs-rollback-home <ID_DO_SNAPSHOT>"
    echo "Dica: Use 'sudo snapper -c home list' para ver os IDs."
    exit 1
fi

ID=$1
# Detecta o disco onde a /home está montada (removendo o sufixo [/@home])
DISK_HOME=$(findmnt -no SOURCE /home | sed 's/\[.*\]//')
MNT="/mnt/reparo_home"

# Verifica se o ID do snapshot existe
if [ ! -d "/home/.snapshots/$ID/snapshot" ]; then
    echo "❌ Erro: Snapshot ID $ID não encontrado em /home/.snapshots/"
    exit 1
fi

echo "==> Iniciando Rollback da HOME..."
sudo mkdir -p "$MNT"
sudo mount -o subvolid=5 "$DISK_HOME" "$MNT"

# 1. Backup do @home atual (caso você se arrependa)
DATA=$(date +%Y-%m-%d_%H:%M:%S)
echo "-> Renomeando @home atual para @home_antigo_$DATA..."
sudo mv "$MNT/@home" "$MNT/@home_antigo_$DATA"

# 2. Restaura o snapshot escolhido como o novo @home
echo "-> Restaurando snapshot $ID como o novo @home..."
sudo btrfs subvolume snapshot "$MNT/@home/.snapshots/$ID/snapshot" "$MNT/@home"

# 3. Garante que o subvolume padrão do disco da home aponte para o novo @home
NEW_ID=$(sudo btrfs subvolume list "$MNT" | grep "path @home$" | awk '{print $2}')
sudo btrfs subvolume set-default "$NEW_ID" "$MNT"

sudo umount "$MNT"

echo "=========================================================="
echo "✅ ROLLBACK DA HOME CONCLUÍDO!"
echo "Snapshot $ID agora é a sua pasta pessoal ativa."
echo "IMPORTANTE: Reinicie o sistema para evitar erros de sessão."
echo "=========================================================="
EOF
sudo chmod +x /usr/local/bin/btrfs-rollback-home

# 6. Finalização
sudo umount "$MNT" "$MNT_H"
sudo systemctl enable --now grub-btrfs.path
sudo update-grub

echo "=========================================================="
echo "CONFIGURAÇÃO APLICADA COM SNAPSHOTS NA HOME"
echo "=========================================================="
