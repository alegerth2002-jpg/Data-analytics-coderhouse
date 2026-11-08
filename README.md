# RetailPro – Análisis de ventas

Proyecto de análisis de datos de **RetailPro**, una distribuidora de tecnología. El objetivo es analizar las ventas, los clientes y los productos para apoyar decisiones comerciales, mediante consultas SQL, un pipeline ETL y un modelo analítico en Power BI.

## Herramientas utilizadas

- SQL Server (T-SQL) y SQL Server Management Studio (SSMS)
- Power BI Desktop
- Power Query (lenguaje M)
- DAX

## Estructura del repositorio

```
Data-analytics-coderhouse/
  ventas_tech_db.sql                    Base Ventas_Tech_DB (Módulo 3)
  m4_consultas_negocio.sql              Consultas de negocio (Módulo 4)
  m5_consultas_joins.sql                Consultas con JOINs (Módulo 5)
  Pipeline_GERTH_ALEXANDER.pbix.pbix    Pipeline ETL en Power Query
  Gerth_Alexander_Checkpoint2.pbix      Modelo de datos y medidas DAX
  README.md                             Este archivo
```

## Cómo ejecutar los scripts SQL

1. Abrir SQL Server Management Studio (SSMS) y conectarse a la instancia de SQL Server.
2. Ejecutar `ventas_tech_db.sql` para crear la base `Ventas_Tech_DB` y sus tablas (`clientes`, `productos`, `categorias` y `ventas`).
3. **Elegir `Ventas_Tech_DB` en el desplegable de bases de datos de SSMS** (o ejecutar `USE Ventas_Tech_DB; GO`) antes de correr cualquier consulta. Si se ejecuta en otra base, SQL Server devuelve el error `Invalid object name 'ventas'`.
4. Abrir `m4_consultas_negocio.sql`, seleccionar **una consulta por vez** y ejecutarla con el botón *Ejecutar* (F5).
5. Repetir el paso 4 con `m5_consultas_joins.sql`.

## Qué analiza el proyecto

- Resumen mensual de ventas: total facturado, cantidad de pedidos y ticket promedio.
- Ranking de productos por facturación.
- Clientes recurrentes, clientes sin compras y productos sin ventas.
- Comparación de ventas entre dos períodos.

> **Nota sobre los datos:** los datos cargados en `Ventas_Tech_DB` corresponden a un único mes (marzo), con 10 pedidos. Las consultas muestran la metodología de análisis, pero con este volumen no permiten estudiar tendencias.

## Modelos de Power BI

- **`Pipeline_GERTH_ALEXANDER.pbix.pbix`**: pipeline ETL (limpieza y transformación con Power Query). Al descargarlo hay que **renombrarlo a `.pbix`** (el nombre actual tiene la extensión repetida). Lee `Pipeline_ETL_Dataset.xlsx`, el archivo provisto por el curso, desde una ruta local de mi equipo: para actualizar los datos hay que cambiar la ruta en *Inicio > Transformar datos > Configuración de origen de datos*.
- **`Gerth_Alexander_Checkpoint2.pbix`**: modelo en estrella (`Fact_Ventas` con `Dim_Clientes`, `Dim_Productos`, `Dim_Categorias` y `Dim_Fechas`, mediante relaciones 1:N) y tabla `_Medidas` con las medidas DAX `Total Ventas`, `Ventas Online`, `Ventas YTD`, `Ventas LY` y `% Crecimiento Anual`.

## Autor

Gerth Alexander · Proyecto integrador RetailPro del curso de Análisis de Datos.
