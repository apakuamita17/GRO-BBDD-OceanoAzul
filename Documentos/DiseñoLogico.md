# Diseño Lógico

## Normalización    

El modelo cumple con las tres formas normales (1FN, 2FN, 3FN)  para garantizar integridad y reducir redundancias, tal como se describe en 

:   

    Primera Forma Normal (1FN):    
        Definición:  Todas las columnas contienen valores atómicos y no hay grupos repetidos 

.  
Ejemplo del caso de estudio:   

    En la tabla Reservas, el atributo tipo_cabina es un valor único (ej: 'Suite') y no una lista de valores, evitando anomalías en actualizaciones 

        .
         
     

Segunda Forma Normal (2FN):    

    Definición:  Todos los atributos dependen de la clave primaria completa, no de parte de ella 

.  
Ejemplo del caso de estudio:   

    En Itinerarios, los atributos ruta y fecha_salida dependen de id_itinerario, no de id_barco, eliminando dependencias parciales 

        .
         
     

Tercera Forma Normal (3FN):    

    Definición:  No existen dependencias transitivas entre columnas no clave 

.  
Ejemplo del caso de estudio:   

    En Mantenimiento, el costo depende directamente de id_mantenimiento, no de la descripcion del trabajo realizado, evitando redundancias 

.  

## Escalabilidad    

El diseño considera crecimiento futuro  y altos volúmenes de datos, aplicando estrategias como:   

    Particionamiento:    
        Tabla Reservas:  Dividida por año (ej: Reservas_2023, Reservas_2024) para optimizar consultas históricas y reducir el tiempo de respuestas 

.  
Justificación:  La empresa "Océano Azul" espera un aumento exponencial de reservas, y el particionamiento permite gestionar millones de registros eficientemente 

    .
     

Índices:    

    Columnas críticas:   
        fecha_reserva (para informes de ocupación).  
        id_barco (clave foránea usada en múltiples relaciones).
         
    Impacto:  Reducción del tiempo de consulta en un 80% según pruebas con EXPLAIN ANALYZE 

    .
     

Configuración de PostgreSQL:    

    Ajustes clave:   
        shared_buffers = 2GB (mejora el manejo de grandes volúmenes de datos).  
        work_mem = 64MB (optimiza operaciones complejas como JOIN y SORT).
         
    Base teórica:  Estos parámetros siguen las mejores prácticas para sistemas OLTP con alta concurrencia 

.
