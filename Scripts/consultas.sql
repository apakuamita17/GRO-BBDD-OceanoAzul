/*Informe de ocupación de barcos:  */

EXPLAIN ANALYZE
SELECT id_barco, COUNT(*) 
FROM Reservas 
WHERE fecha_reserva BETWEEN '2025-03-01' AND '2025-04-01'
GROUP BY id_barco;

/*Consulta de historial de mantenimiento*/

EXPLAIN ANALYZE
SELECT * FROM Mantenimiento 
WHERE costo > 100000 
ORDER BY fecha_inicio DESC;

/*Informe de costos operativos*/

SELECT id_barco, SUM(costo) 
FROM Mantenimiento 
GROUP BY id_barco;

/*Informe de Satisfacción del Cliente */

SELECT 
    id_crucero, 
    AVG(calificacion) AS promedio_satisfaccion,
    COUNT(*) AS total_respuestas
FROM EncuestasSatisfaccion
WHERE fecha_crucero BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY id_crucero;

/*Informe de Ingresos por Crucero */

SELECT 
    i.id_crucero, 
    SUM(r.precio) AS ingresos_totales,
    COUNT(r.id_reserva) AS total_pasajeros
FROM Reservas r
JOIN Itinerarios i ON r.id_itinerario = i.id_itinerario
GROUP BY i.id_crucero;

/*Consulta de inventario crítico*/

SELECT * FROM Suministros 
WHERE cantidad < 100 AND tipo = 'combustible';

/*Notificaciones pendientes*/

SELECT * FROM Notificaciones 
WHERE fecha_envio > NOW() - INTERVAL '7 days';

/* Vista materializada para informes rápidos */
CREATE MATERIALIZED VIEW MV_Ingresos_Cruceros AS
SELECT i.id_itinerario, b.nombre AS barco, SUM(r.precio) AS ingresos_totales
FROM Reservas r
JOIN Itinerarios i ON r.id_itinerario = i.id_itinerario
JOIN Barcos b ON i.id_barco = b.id_barco
GROUP BY i.id_itinerario, b.nombre;