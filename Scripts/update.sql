-- INICIO DE TRANSACCIÓN
BEGIN;

-- 1. Actualizar año de construcción de barcos con formato incorrecto
UPDATE Barcos 
SET año_construccion = '2020-01-01' 
WHERE año_construccion IS NULL;

-- 2. Aumentar costo de mantenimiento en un 10% para reparaciones urgentes
UPDATE Mantenimiento 
SET costo = costo * 1.10 
WHERE tipo = 'Reparaciones' 
AND fecha_fin IS NULL;

-- 3. Extender duración de itinerarios en temporada alta (ej: +2 días)
UPDATE Itinerarios 
SET duracion_dias = duracion_dias + 2, 
    fecha_llegada = fecha_llegada + INTERVAL '2 days' 
WHERE fecha_salida BETWEEN '2025-06-01' AND '2025-08-31';

-- 4. Corregir correos electrónicos duplicados en Pasajeros
UPDATE Pasajeros 
SET email = CONCAT('new_', email) 
WHERE id_pasajero IN (
    SELECT id_pasajero 
    FROM Pasajeros 
    GROUP BY email 
    HAVING COUNT(email) > 1
);

-- 5. Actualizar precios de reservas según tipo de cabina
UPDATE Reservas 
SET precio = CASE 
    WHEN tipo_cabina = 'Suite' THEN precio * 1.15 
    WHEN tipo_cabina = 'Premium' THEN precio * 1.10 
    ELSE precio 
END;

-- 6. Reducir cantidad de suministros críticos (ej: combustible)
UPDATE Suministros 
SET cantidad = cantidad - 100 
WHERE tipo = 'Combustible' 
AND cantidad > 500;

-- 7. Marcar notificaciones como leídas
UPDATE Notificaciones 
SET mensaje = 'LEÍDO: ' || mensaje 
WHERE fecha_envio < CURRENT_DATE - INTERVAL '7 days';

-- 8. Actualizar calificación en encuestas con comentarios positivos
UPDATE EncuestasSatisfaccion 
SET calificacion = 5 
WHERE comentarios LIKE '%excelente%' 
OR comentarios LIKE '%recomendaría%';

-- FIN DE TRANSACCIÓN
COMMIT;