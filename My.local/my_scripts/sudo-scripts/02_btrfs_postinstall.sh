#!/usr/bin/env bash
set -euo pipefail

# ==========================================================
# PÓS-INSTALAÇÃO BTRFS + SNAPPER (Ubuntu/Debian)
# ==========================================================

# ==========================================================
# Comando BTRFS:

# Lista todas as snapshots criadas em /.snapshots
# sudo snapper list

# Lista todas as volumes da partição
# sudo btrfs subvolume list /  

# Criar nova snapshot
# sudo snapper create -d "description"

# Remover snapshot de /.snapshots
# sudo snapper delete <ID>

# Remover Volumes da partição (necessario que que a partição esteja montada em /mnt)
# sudo btrfs subvolume delete /mnt/@_antigo*

# Montar partição em /mnt
# sudo mount /dev/sda1 /mnt -o subvolid=5  

# Voltar para uma snapshot especifica
# sudo btrfs-rollback <ID>
# ==========================================================

# 1. Detecção Automática (Limpando o sufixo [/@] se existir)
DISK=$(findmnt -no SOURCE / | sed 's/\[.*\]//')
ROOT_UUID=$(sudo blkid -p -s UUID -o value "$DISK")
MNT="/mnt/btrfs_root"

echo "==> Verificando Btrfs..."
findmnt -n -o FSTYPE / | grep -q btrfs || { echo "Erro: Não é Btrfs"; exit 1; }

# 2. Instalando e Configurando grub-btrfs e Snapper
echo "==> Instalando ferramentas essenciais..."
sudo apt update && sudo linuxtoys-cli --install --script grub-btrfs -y
sudo snapper -c root set-config "ALLOW_GROUPS=sudo" "SYNC_ACL=yes"

# echo "==> Configurando Snapper para Home..."
# sudo snapper -c home create-config /home || true
# sudo snapper -c home set-config "ALLOW_GROUPS=sudo" "SYNC_ACL=yes"

# 3. Montagem da Raiz do Disco (subvolid=5)
echo "==> Preparando layout de subvolumes..."
sudo mkdir -p "$MNT"
# Aqui o $DISK agora estará limpo (ex: /dev/sda1)
sudo mount -o subvolid=5 "$DISK" "$MNT"

# --- SEÇÃO 2.5: VERIFICAÇÃO E CRIAÇÃO DO @ ---
echo "==> Verificando se a raiz está no subvolume @..."
if ! btrfs subvolume list "$MNT" | grep -q "path @$"; then
    echo "  ⚠️  AVISO: Subvolume @ não encontrado. Criando agora..."
    sudo btrfs subvolume snapshot "$MNT" "$MNT/@"
    echo "  ✅ Subvolume @ criado com sucesso a partir da raiz atual."
else
    echo "  ✅ OK: Subvolume @ já existe."
fi

# --- SEÇÃO @HOME ---
#echo "==> Verificando subvolume @home..."
#if ! btrfs subvolume list "$MNT" | grep -q "path @home$"; then
#    echo "  ⚠️  @home não encontrado. Criando a partir do conteúdo atual de /home..."
#    sudo btrfs subvolume create "$MNT/@home"
#    # Se houver arquivos em /home, movemos para o novo subvolume
#    # (Nota: isso deve ser feito com cautela se o sistema já estiver em uso pesado)
#    sudo rsync -aX /home/ "$MNT/@home/"
#    echo "  ✅ Subvolume @home preparado."
#else
#    echo "  ✅ OK: Subvolume @home já existe."
#fi
# ---------------------------------------------

# Converter .snapshots de diretório para subvolume (no nível 5)
if ! btrfs subvolume list "$MNT" | grep -q "path .snapshots$"; then
    echo "  -> Convertendo /.snapshots em subvolume Btrfs..."
    sudo umount /.snapshots 2>/dev/null || true
    [ -d "/.snapshots" ] && sudo rm -rf /.snapshots
    sudo btrfs subvolume create "$MNT/.snapshots"
fi

# 4. Ajustando FSTAB
echo "==> Ajustando /etc/fstab para o próximo boot..."
sudo sed -i '/ \/ /d' /etc/fstab
sudo sed -i '/ \/\.snapshots /d' /etc/fstab
#sudo sed -i '/ \/home /d' /etc/fstab

echo "UUID=$ROOT_UUID / btrfs subvol=@,defaults,noatime,compress=zstd 0 1" | sudo tee -a /etc/fstab
echo "UUID=$ROOT_UUID /.snapshots btrfs subvol=.snapshots,defaults,noatime,compress=zstd 0 0" | sudo tee -a /etc/fstab
#echo "UUID=$ROOT_UUID /home btrfs subvol=@home,defaults,noatime,compress=zstd 0 0" | sudo tee -a /etc/fstab

# 5. Script Auxiliar de Rollback
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

# 6. Finalização
echo "==> Atualizando GRUB..."
sudo systemctl enable --now grub-btrfs.path
sudo update-grub

echo "=========================================================="
echo "CONFIGURAÇÃO APLICADA"
echo "DISK detectado: $DISK"
echo "O sistema foi configurado para subir no subvolume @ no próximo boot."
echo "Reinicie agora para validar!"
echo "=========================================================="

exec $SHELL
