-- Vista de ocupación de barcos
CREATE VIEW Vista_Ocupacion AS
SELECT 
    b.nombre AS barco,
    COUNT(r.id_reserva) AS total_reservas,
    SUM(r.precio) AS ingresos_totales
FROM Barcos b
LEFT JOIN Reservas r ON b.id_barco = r.id_barco
GROUP BY b.nombre;

-- Vista de mantenimiento reciente
CREATE VIEW Vista_Mantenimiento_Reciente AS
SELECT 
    b.nombre AS barco,
    m.tipo AS tipo_mantenimiento,
    m.fecha_inicio,
    m.costo
FROM Mantenimiento m
JOIN Barcos b ON m.id_barco = b.id_barco
WHERE m.fecha_inicio >= CURRENT_DATE - INTERVAL '6 months';