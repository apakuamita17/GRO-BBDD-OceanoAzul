#!/bin/bash

# Variables
BACKUP_DIR="/backups/base"
DATE=$(date +%Y%m%d)

# Crear directorio si no existe
mkdir -p $BACKUP_DIR

# Ejecutar pg_basebackup
pg_basebackup -U postgres -D "$BACKUP_DIR/$DATE" -Ft -z -P

# Limpiar backups antiguos (opcional)
find $BACKUP_DIR -type d -mtime +7 -exec rm -r {} \;