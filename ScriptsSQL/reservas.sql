-- Add missing import statement
CREATE EXTENSION IF NOT EXISTS pg_partman;

/*Tabla Reservas (por año):*/   

CREATE TABLE Reservas_2025 PARTITION OF Reservas
FOR VALUES FROM ('2025-01-01') TO ('2025-12-31');

/*Automatización con pg_partman*/

SELECT partman.create_parent('public.Reservas', 'fecha_reserva', 'native', 'yearly');