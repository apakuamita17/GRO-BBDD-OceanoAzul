-- Insertar barcos
INSERT INTO Barcos (nombre, tipo, capacidad_pasajeros, capacidad_tripulacion, numero_camarotes)
VALUES
    ('Azul Marinoso', 'Lujo', 2000, 800, 500),
    ('Familia Feliz', 'Familiar', 1500, 600, 400);

-- Insertar mantenimientos para barcos específicos
INSERT INTO Mantenimiento (id_barco, tipo, fecha_inicio, fecha_fin, personal_tecnico_responsable, costo, descripcion_trabajo)
VALUES
    ('123e4567-e89b-12d3-a456-426614174000', 'Preventivo', '2025-01-15', '2025-01-20', 'Equipo A', 15000.00, 'Revisión de motores y sistemas eléctricos'),
    ('123e4567-e89b-12d3-a456-426614174001', 'Correctivo', '2025-02-10', '2025-02-18', 'Equipo B', 25000.50, 'Reparación de fugas en tanques de agua'),
    ('123e4567-e89b-12d3-a456-426614174002', 'Reparaciones', '2025-03-05', NULL, 'Equipo C', 8000.75, 'Mantenimiento urgente de sistemas de navegación');

-- Insertar itinerarios
INSERT INTO Itinerarios (id_barco, ruta, puerto_escala, fecha_salida, fecha_llegada, duracion_dias)
VALUES
    (1, 'Caribe Norte', 'Miami', '2025-03-01', '2025-03-07', 6),
    (2, 'Mediterráneo', 'Barcelona', '2025-04-15', '2025-04-22', 7);

-- Insertar pasajeros
INSERT INTO Pasajeros (nombre, apellidos, numero_pasaporte, email)
VALUES
    ('Juan', 'Pérez', pgp_sym_encrypt('A12345678', 'clave_secreta'), 'juan.perez@example.com'),
    ('María', 'Gómez', pgp_sym_encrypt('B98765432', 'clave_secreta'), 'maria.gomez@example.com');

-- Insertar reservas
INSERT INTO Reservas (id_pasajero, id_itinerario, tipo_cabina, fecha_embarque, fecha_desembarque, precio)
VALUES
    (1, 1, 'Suite', '2025-03-01', '2025-03-07', 5000.00),
    (2, 2, 'Premium', '2025-04-15', '2025-04-22', 3500.00);

-- Insertar suministros para barcos y proveedores
INSERT INTO Suministros (tipo, cantidad_stock, proveedor, fecha_entrega)
VALUES
    ('Combustible', 5000, 'Petróleos del Mar S.A.', '2025-01-10'),
    ('Alimentos', 2000, 'Alimentos Marinos C.A.', '2025-02-05'),
    ('Repuestos', 150, 'NavalTech Repuestos', '2025-03-20');

-- Insertar notificaciones para pasajeros y tripulación
INSERT INTO Notificaciones (mensaje, id_pasajero, id_tripulante)
VALUES
    ('Su reserva para el crucero 2025-03-15 ha sido confirmada.', '123e4567-e89b-12d3-a456-426614174000', NULL),
    ('Mantenimiento programado: Sistema eléctrico revisado.', NULL, 'tripulante_001'),
    ('¡Nueva promoción! 10% de descuento en excursiones.', '123e4567-e89b-12d3-a456-426614174001', NULL);

-- Insertar encuestas de satisfacción con calificaciones y comentarios
INSERT INTO EncuestasSatisfaccion (id_crucero, calificacion, fecha_crucero, comentarios)
VALUES
    ('crucero_2025_01', 4, '2025-03-15', 'Excelente servicio, camarotes limpios.'),
    ('crucero_2025_02', 5, '2025-04-20', 'Actividades en tierra muy organizadas.'),
    ('crucero_2025_03', 3, '2025-05-10', 'El menú podría mejorar.');