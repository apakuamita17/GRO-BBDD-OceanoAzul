-- Cifrado de datos sensibles
ALTER TABLE Pasajeros 
ALTER COLUMN numero_pasaporte TYPE TEXT USING pgp_sym_encrypt(numero_pasaporte, 'clave_secreta');

-- Control de acceso basado en roles
CREATE ROLE administrador WITH LOGIN PASSWORD 'secure123';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO administrador;

CREATE ROLE auditor WITH LOGIN PASSWORD 'auditor123';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO auditor;