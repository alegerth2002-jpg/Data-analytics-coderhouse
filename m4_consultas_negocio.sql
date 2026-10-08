-- ============================================================================
-- PRE-ENTREGA 4: Consultas SQL de Negocio
-- Archivo: m4_consultas_negocio.sql
-- Base de Datos: Ventas_Tech_DB
-- ============================================================================

USE Ventas_Tech_DB;
GO

-- ----------------------------------------------------------------------------
-- Consulta 1: Resumen ejecutivo mensual
-- Total facturado, cantidad de pedidos y ticket promedio por mes.
-- ----------------------------------------------------------------------------
SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(id_venta) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;
GO

-- ----------------------------------------------------------------------------
-- Consulta 2: Ranking de productos
-- Top 5 de id_producto por total facturado.
-- ----------------------------------------------------------------------------
SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;
GO

-- ----------------------------------------------------------------------------
-- Consulta 3: Clientes recurrentes
-- id_cliente que hayan realizado más de un pedido.
-- ----------------------------------------------------------------------------
SELECT 
    id_cliente,
    COUNT(id_venta) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(id_venta) > 1
ORDER BY cantidad_pedidos DESC;
GO

-- ----------------------------------------------------------------------------
-- Consulta 4: Meses por encima/por debajo del promedio
-- Compara la facturación de cada mes con el promedio mensual general.
-- ----------------------------------------------------------------------------
-- Usamos una tabla temporal (CTE) para calcular primero los totales por mes
-- y luego poder compararlos limpiamente con el promedio.
WITH VentasMensuales AS (
    SELECT 
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_mes
    FROM ventas
    GROUP BY MONTH(fecha_venta)
)
SELECT 
    mes,
    total_mes AS total_facturado,
    CASE 
        WHEN total_mes > (SELECT AVG(total_mes) FROM VentasMensuales) THEN 'Por encima'
        WHEN total_mes < (SELECT AVG(total_mes) FROM VentasMensuales) THEN 'Por debajo'
        ELSE 'Promedio exacto'
    END AS rendimiento_mensual
FROM VentasMensuales
ORDER BY mes;
GO

-- ============================================================================
-- HALLAZGOS CONCRETOS
-- ============================================================================
-- 1. El producto con id_producto 1 lidera cómodamente el ranking de facturación total, demostrando que los artículos de alto valor unitario impactan más que los de alto volumen de ventas.
-- 2. Existe una base sólida de clientes recurrentes (clientes con id 1 al 5 tienen todos más de 1 pedido), lo que indica un buen nivel de retención.
-- 3. Dado que los datos cargados corresponden íntegramente al mes 3 (Marzo), el volumen de pedidos mensuales y el análisis de promedios mostrarán todo el peso concentrado en este único período inicial.