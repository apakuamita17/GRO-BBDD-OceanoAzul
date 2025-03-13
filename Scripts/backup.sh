#!/bin/bash

# Variables
DB_NAME="oceano_azul"
USER="postgres"
BACKUP_DIR="/backups"
DATE=$(date +%Y%m%d)

# Crear directorio si no existe
mkdir -p $BACKUP_DIR

# Ejecutar pg_dump
pg_dump -U $USER -Fc -f "$BACKUP_DIR/$DB_NAME-$DATE.dump" $DB_NAME

# Limpiar backups antiguos (opcional)
find $BACKUP_DIR -type f -mtime +7 -exec rm {} \;