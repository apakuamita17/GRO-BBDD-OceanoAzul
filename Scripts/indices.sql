-- Creación de informes de ocupación

CREATE INDEX idx_fecha_barco ON Reservas(fecha_reserva, id_barco);

/*Resultado en EXPLAIN ANALYZE:   

    "Reducción del costo de consulta de 1200 a 300 al evitar escaneo secuencial" (ver execution_plans/reserva_fecha.txt).  

 Índices Funcionales 

    Optimización de búsquedas por temporada: */

    CREATE INDEX idx_temporada ON Itinerarios(fecha_salida::DATE);

-- Índices para informes de mantenimiento
CREATE INDEX idx_mantenimiento_costo ON Mantenimiento(id_barco, costo);

-- Consulta de suministros críticos: 

CREATE INDEX idx_suministros_criticos ON Suministros(tipo, cantidad);

-- Índices para encuestas de satisfacción
CREATE INDEX idx_encuestas_crucero ON EncuestasSatisfaccion(id_crucero);
CREATE INDEX idx_encuestas_calificacion ON EncuestasSatisfaccion(calificacion);

-- Índices compuestos para optimización
CREATE INDEX idx_reservas_fecha_barco ON Reservas(fecha_embarque, id_barco);

-- Índices para consultas específicas
CREATE INDEX idx_suministros_criticos ON Suministros(tipo, cantidad);
CREATE INDEX idx_notificaciones_fecha_envio ON Notificaciones(fecha_envio);

-- Índice funcional para rangos de fechas
CREATE INDEX idx_reservas_mes ON Reservas(EXTRACT(MONTH FROM fecha_embarque));

-- Índices para Comunicación  
CREATE INDEX idx_notificaciones_fecha_envio ON Notificaciones(fecha_envio);

-- Índices Funcionales Adicionales  
CREATE INDEX idx_reservas_mes ON Reservas(EXTRACT(MONTH FROM fecha_embarque));
