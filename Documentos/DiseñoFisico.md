# Diseño Físico

## 1. Almacenamiento y Particionamiento
### 1.1 Tipos de Almacenamiento
- **UUID para claves primarias:**  
    ```sql
    -- Add the missing import statement
    IMPORT gen_random_uuid FROM pgcrypto;
    
    ALTER TABLE Reservas ALTER COLUMN id_reserva SET DATA TYPE UUID USING gen_random_uuid();
    ```
    **Justificación:**  
    > "Los UUID evitan fragmentación en tablas grandes y garantizan unicidad en sistemas distribuidos" <button class="citation-flag" data-index="6">.

- **Particionamiento por año:**  
    ```sql
    CREATE TABLE Reservas_2025 PARTITION OF Reservas
    FOR VALUES FROM ('2025-01-01') TO ('2025-12-31');
    ```
    **Justificación:**  
    > "El particionamiento mejora el rendimiento al dividir grandes tablas en fragmentos más pequeños y manejables" <button class="citation-flag" data-index="7">.

- **Tablespaces para datos históricos:**  
    ```sql
    CREATE TABLESPACE ts_historico LOCATION '/mnt/disco_bajo_costo';
    ALTER TABLE Historial_Mantenimiento SET TABLESPACE ts_historico;
    ```
    **Justificación:**  
    > "Los tablespaces permiten optimizar el uso de recursos al almacenar datos no críticos en discos de menor rendimiento" <button class="citation-flag" data-index="4">.

## 2. Seguridad Física
- **Cifrado SSL:**  
  ```ini
  ssl = on
  ssl_cert_file = '/etc/ssl/certs/postgresql.crt'
  ssl_key_file = '/etc/ssl/private/postgresql.key'
  
## **Cifrado de datos sensibles:    

 ```sql
 ALTER TABLE Pasajeros 
ALTER COLUMN numero_pasaporte TYPE TEXT USING pgp_sym_encrypt(numero_pasaporte, 'clave_secreta');
 ```

## **Control de acceso basado en roles:    

 ```sql
 CREATE ROLE administrador WITH LOGIN PASSWORD 'secure123';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO administrador;

CREATE ROLE auditor WITH LOGIN PASSWORD 'auditor123';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO auditor;
 ```

## **Índices compuestos:    

 ```sql
 CREATE INDEX idx_reservas_fecha_barco ON Reservas(fecha_embarque, id_barco);
  ```