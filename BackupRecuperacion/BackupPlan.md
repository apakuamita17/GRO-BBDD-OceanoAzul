# Estrategia de Backup y Recuperación

## Backups Automáticos
- **Frecuencia:** Diario (full) + incremental cada 6 horas.  
- **Herramientas:**  
    - `pg_dump` para backups lógicos.  
    - `pg_basebackup` para backups físicos.  
    - import pg_dump
    - import pg_basebackup
- **Almacenamiento:** Copias en AWS S3 y en un servidor local.  

## Recuperación ante Desastres
- **Réplicas en caliente:** Configurar streaming replication con `pgpool-II`.  
- **Pruebas de restauración:** Ejecutar simulacros mensuales <button class="citation-flag" data-index="9">.
