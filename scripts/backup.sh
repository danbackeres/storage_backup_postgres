#!/bin/bash

# Variáveis
PGUSER="postgres"
DATABASE="teste"
STORAGE_USER="userteste"
STORAGE_PASS="123456"
STORAGE_URL="//storage-container/backup"
MOUNT_POINT="/mnt/storage"
DATE=$(date +"%Y%m%d%H%M")

# Criar o ponto de montagem se não existir
if [ ! -d "$MOUNT_POINT" ]; then
  mkdir -p $MOUNT_POINT
fi

# Montar o storage
echo "Montando o storage..."
mount -t cifs -o username=$STORAGE_USER,password=$STORAGE_PASS,vers=3.0 $STORAGE_URL $MOUNT_POINT

if [ $? -ne 0 ]; then
  echo "Erro ao montar o storage."
  exit 1
fi

# Exportar PGPASSFILE
export PGPASSFILE=~/.pgpass

# Executar o pg_dump e salvar no storage
echo "Executando pg_dump..."
pg_dump -U $PGUSER -F c $DATABASE > $MOUNT_POINT/${DATABASE}_$DATE.backup

if [ $? -ne 0 ]; then
  echo "Erro ao fazer o backup do banco de dados."
  umount $MOUNT_POINT
  exit 1
fi

echo "Backup concluído com sucesso."

# Limpar backups antigos no storage
mount -t cifs -o username=$STORAGE_USER,password=$STORAGE_PASS,vers=3.0 $STORAGE_URL $MOUNT_POINT
find $MOUNT_POINT -type f -name "${DATABASE}_*.backup" -mtime +7 -exec rm {} \;

# Desmonta o Storage
umount $MOUNT_POINT
