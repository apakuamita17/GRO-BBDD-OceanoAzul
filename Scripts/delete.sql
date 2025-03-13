-- INICIO DE TRANSACCIÓN 
BEGIN;

-- 1. Eliminar barcos sin itinerarios asociados
DELETE FROM Barcos 
WHERE id_barco NOT IN (SELECT id_barco FROM Itinerarios);

-- 2. Eliminar mantenimientos finalizados con más de 1 año de antigüedad
DELETE FROM Mantenimiento 
WHERE fecha_fin < CURRENT_DATE - INTERVAL '1 year';

-- 3. Eliminar itinerarios con fecha de salida pasada y sin reservas
DELETE FROM Itinerarios 
WHERE fecha_salida < CURRENT_DATE 
AND id_itinerario NOT IN (SELECT id_itinerario FROM Reservas);

-- 4. Eliminar pasajeros sin reservas
DELETE FROM Pasajeros 
WHERE id_pasajero NOT IN (SELECT id_pasajero FROM Reservas);

-- 5. Eliminar reservas canceladas (ej: precio = 0)
DELETE FROM Reservas 
WHERE precio = 0;

-- 6. Eliminar suministros con cantidad = 0 y más de 6 meses sin entrega
DELETE FROM Suministros 
WHERE cantidad = 0 
AND fecha_entrega < CURRENT_DATE - INTERVAL '6 months';

-- 7. Eliminar notificaciones con más de 30 días de antigüedad
DELETE FROM Notificaciones 
WHERE fecha_envio < CURRENT_DATE - INTERVAL '30 days';

-- 8. Eliminar encuestas de cruceros finalizados hace más de 2 años
DELETE FROM EncuestasSatisfaccion 
WHERE fecha_crucero < CURRENT_DATE - INTERVAL '2 years';

-- FIN DE TRANSACCIÓN
COMMIT;