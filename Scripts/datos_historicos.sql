-- Justificación: Reduce costos al almacenar datos no críticos en discos de menor rendimiento
CREATE TABLESPACE ts_historico LOCATION '/mnt/disco_bajo_costo';
ALTER TABLE Historial_Mantenimiento SET TABLESPACE ts_historico;
