-- Tabla Barcos
CREATE TABLE Barcos (
    id_barco UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) CHECK (tipo IN ('Lujo', 'Familiar')),
    capacidad_pasajeros INT CHECK (capacidad_pasajeros > 0),
    capacidad_tripulacion INT CHECK (capacidad_tripulacion > 0),
    numero_camarotes INT CHECK (numero_camarotes > 0),
    caracteristicas_tecnicas JSONB,
    año_construccion DATE,
    historial_mantenimiento JSONB
);

-- Tabla Mantenimiento
CREATE TABLE Mantenimiento (
    id_mantenimiento SERIAL PRIMARY KEY,
    id_barco UUID REFERENCES Barcos(id_barco),
    tipo VARCHAR(50) CHECK (tipo IN ('Preventivo', 'Correctivo', 'Reparaciones')),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    personal_tecnico_responsable VARCHAR(100),
    costo NUMERIC(10, 2),
    descripcion TEXT
);

-- Tabla Itinerarios
CREATE TABLE Itinerarios (
    id_itinerario SERIAL PRIMARY KEY,
    id_barco UUID REFERENCES Barcos(id_barco),
    ruta VARCHAR(255),
    puerto_escala VARCHAR(100),
    fecha_salida DATE NOT NULL,
    fecha_llegada DATE NOT NULL,
    duracion_dias INT CHECK (duracion_dias > 0)
);

-- Tabla Pasajeros
CREATE TABLE Pasajeros (
    id_pasajero UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    numero_pasaporte TEXT UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Tabla Reservas
CREATE TABLE Reservas (
    id_reserva UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_pasajero UUID REFERENCES Pasajeros(id_pasajero),
    id_itinerario INT REFERENCES Itinerarios(id_itinerario),
    tipo_cabina VARCHAR(50) CHECK (tipo_cabina IN ('Suite', 'Premium', 'Económica')),
    fecha_embarque DATE NOT NULL,
    fecha_desembarque DATE NOT NULL,
    precio NUMERIC(10, 2) CHECK (precio > 0)
);

-- Tabla Suministros
CREATE TABLE Suministros (
    id_suministro SERIAL PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    cantidad INT CHECK (cantidad >= 0),
    proveedor VARCHAR(100),
    fecha_entrega DATE,
    id_barco UUID REFERENCES Barcos(id_barco)
);

-- Tabla Notificaciones
CREATE TABLE Notificaciones (
    id_notificacion SERIAL PRIMARY KEY,
    mensaje TEXT NOT NULL,
    fecha_envio TIMESTAMP DEFAULT NOW(),
    id_pasajero UUID REFERENCES Pasajeros(id_pasajero),
    id_tripulante UUID REFERENCES Tripulacion(id_tripulante)
);

-- Tabla EncuestasSatisfaccion
CREATE TABLE EncuestasSatisfaccion (
    id_encuesta SERIAL PRIMARY KEY,
    id_crucero UUID REFERENCES Cruceros(id_crucero),
    calificacion INT CHECK (calificacion BETWEEN 1 AND 5),
    fecha_crucero DATE NOT NULL,
    comentarios TEXT
);