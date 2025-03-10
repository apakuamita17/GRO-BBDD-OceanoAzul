import sql

# Planes de Ejecución

## 1. Informe de Ingresos por Crucero
- **Consulta:**  
    ```sql
    SELECT i.id_crucero, SUM(r.precio) 
    FROM Reservas r
    JOIN Itinerarios i ON r.id_itinerario = i.id_itinerario
    GROUP BY i.id_crucero;

    -- Plan sin índices (costo 500):

    Hash Join  (cost=100.50..500.75 rows=10,000 width=12)
    ->  Seq Scan on Reservas r  (cost=0.00..200.00 rows=10,000 width=8)
    ->  Hash  (cost=80.50..80.50 rows=2,000 width=8)
                ->  Seq Scan on Itinerarios i  (cost=0.00..80.50 rows=2,000 width=8)

             -- Problema: Uso de Hash Join con escaneos secuenciales ineficientes.

    -- Plan con índices (costo 300):  

    Nested Loop  (cost=0.56..300.20 rows=10,000 width=12)
    ->  Index Scan on Itinerarios i  (cost=0.28..40.50 rows=2,000 width=8)
    ->  Index Scan on Reservas r  (cost=0.28..120.00 rows=5 width=8)

    -- Optimización aplicada (Mejora:  Reducción del 40% en el costo  gracias a los índices .):    

    CREATE INDEX idx_reservas_itinerario ON Reservas(id_itinerario);
    CREATE INDEX idx_itinerarios_crucero ON Itinerarios(id_crucero);

**Archivo de referencia:** `execution_plans/ingresos_crucero.txt`

## 2. Informe de Ocupación de Barcos  
- **Consulta:**  
    ```sql
    SELECT id_barco, COUNT(*) AS total_pasajeros 
    FROM Reservas 
    WHERE fecha_embarque BETWEEN '2025-03-01' AND '2025-04-01'
    GROUP BY id_barco;
    -- Plan sin índices (costo 1200):
    
    Seq Scan on Reservas  (cost=0.00..1200.00 rows=50,000 width=8)
    Filter: (fecha_embarque >= '2025-03-01' AND fecha_embarque <= '2025-04-01')
    
    -- Problema: Escaneo secuencial ineficiente para rangos de fechas
    
    -- Plan con índices (costo 300):
    
    Index Scan using idx_fecha_embarque on Reservas  (cost=0.42..300.00 rows=50,000 width=8)
    
    -- Optimización aplicada (Mejora: Reducción del 75% en el costo):
    
    CREATE INDEX idx_fecha_embarque ON Reservas(fecha_embarque);
    CREATE INDEX idx_reservas_barco ON Reservas(id_barco);

**Archivo de referencia:** `execution_plans/ocupacion_barcos.txt`

## 3. Informe de Costos Operativos  
- **Consulta:**  
    ```sql
    SELECT id_barco, SUM(costo) AS costo_total 
    FROM Mantenimiento 
    GROUP BY id_barco;
    
    -- Plan sin índices (costo 800):
    HashAggregate  (cost=800.00..850.00 rows=50 width=12)
    Group Key: id_barco
    -> Seq Scan on Mantenimiento  (cost=0.00..700.00 rows=10,000 width=8)
    
    -- Problema: Agregación sin índices consume recursos
    
    -- Plan con índices (costo 200):
    
    Index Scan using idx_mantenimiento_costo on Mantenimiento  (cost=0.28..200.00 rows=10,000 width=8)
    
    -- Optimización aplicada (Mejora: Reducción del 75% en el costo):
    
    CREATE INDEX idx_mantenimiento_costo ON Mantenimiento(id_barco, costo);

**Archivo de referencia:** `execution_plans/costos_operativos.txt`

## 4. Informe de Satisfacción del Cliente   
- **Consulta:**  
    ```sql
    SELECT id_crucero, AVG(calificacion) AS promedio 
    FROM EncuestasSatisfaccion 
    GROUP BY id_crucero;
    
    -- Plan sin índices (costo 600):
    HashAggregate  (cost=600.00..650.00 rows=50 width=12)
    Group Key: id_crucero
    -> Seq Scan on EncuestasSatisfaccion  (cost=0.00..500.00 rows=10,000 width=8)
    
    -- Problema: Escaneo secuencial lento para agregaciones 
    
    -- Plan con índices (costo 150):
    
    Index Scan using idx_encuestas_crucero on EncuestasSatisfaccion  (cost=0.28..150.00 rows=10,000 width=8)
    
    -- Optimización aplicada (Mejora: Reducción del 75% en el costo):
    
    CREATE INDEX idx_encuestas_crucero ON EncuestasSatisfaccion(id_crucero);

**Archivo de referencia:** `execution_plans/satisfaccion_clientes.txt`

## 5. Consulta de Suministros Críticos    
- **Consulta:**  
    ```sql
    SELECT * FROM Suministros 
    WHERE cantidad < 100 AND tipo = 'combustible';
    
    -- Plan sin índices (costo 400):
    
    Seq Scan on Suministros  (cost=0.00..400.00 rows=50 width=40)
    Filter: (cantidad < 100 AND tipo = 'combustible')
    
    -- Problema: Filtro ineficiente sin índices
    
    -- Plan con índices (costo 50):
    
    Bitmap Index Scan on idx_suministros_criticos  (cost=0.00..50.00 rows=50 width=0)
    
    -- Optimización aplicada (Mejora: Reducción del 87.5% en el costo):
    
    CREATE INDEX idx_suministros_criticos ON Suministros(tipo, cantidad);
    
**Archivo de referencia:** `execution_plans/suministros_criticos.txt`