-- Gestión de Suministros
CREATE TABLE Suministros (
    id_suministro SERIAL PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    cantidad INT CHECK (cantidad >= 0),
    proveedor VARCHAR(100),
    fecha_entrega DATE,
    id_barco UUID REFERENCES Barcos(id_barco)
);

-- Comunicación Interna
CREATE TABLE Notificaciones (
    id_notificacion SERIAL PRIMARY KEY,
    mensaje TEXT NOT NULL,
    fecha_envio TIMESTAMP DEFAULT NOW(),
    id_pasajero UUID REFERENCES Pasajeros(id_pasajero),
    id_tripulante UUID REFERENCES Tripulacion(id_tripulante)
);

-- Tabla para Encuestas de Satisfacción
CREATE TABLE EncuestasSatisfaccion (
    id_encuesta SERIAL PRIMARY KEY,
    id_crucero UUID REFERENCES Cruceros(id_crucero),
    calificacion INT CHECK (calificacion BETWEEN 1 AND 5),
    fecha_crucero DATE NOT NULL,
    comentarios TEXT
);

-- Tabla para Mantenimiento
CREATE TABLE Mantenimiento (
    id_mantenimiento SERIAL PRIMARY KEY,
    id_barco UUID REFERENCES Barcos(id_barco),
    tipo VARCHAR(50) NOT NULL,
    fecha_inicio DATE,
    fecha_fin DATE,
    costo NUMERIC(10,2),
    descripcion TEXT
);