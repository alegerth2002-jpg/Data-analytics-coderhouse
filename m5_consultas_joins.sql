
-- ---------------------------------------------------------------------
-- Consulta 1: Vista base del proyecto (INNER JOIN)
-- Propósito: una sola fila por venta con cliente, producto, categoría y
-- ciudad. Es la fuente de datos principal del dashboard de Power BI (M7).
-- ---------------------------------------------------------------------

SELECT
    v.fecha_venta,
    c.id_cliente,
    c.nombre                    AS cliente,
    c.ciudad,
    p.nombre_producto           AS producto,
    cat.nombre_categoria        AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas v
INNER JOIN clientes   c   ON v.id_cliente   = c.id_cliente
INNER JOIN productos  p   ON v.id_producto  = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;
GO


-- ---------------------------------------------------------------------
-- Consulta 2: Clientes sin ventas (LEFT JOIN)
-- Propósito: detectar clientes registrados que nunca compraron, para que
-- CRM los contacte.
-- ---------------------------------------------------------------------
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;
GO


-- ---------------------------------------------------------------------
-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- Propósito: identificar artículos del catálogo sin movimiento, para que
-- el área de producto decida promoción, rebaja o baja del catálogo.
-- ---------------------------------------------------------------------
SELECT
    p.nombre_producto AS producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;
GO

-- ---------------------------------------------------------------------
-- Consulta 4: Consolidado por canal (UNION ALL)
-- Propósito: comparar el total vendido entre dos períodos (orígenes). La columna
-- "canal" se crea como valor literal en cada SELECT.
-- ---------------------------------------------------------------------
SELECT
    canal,
    SUM(total) AS total_canal
FROM (
    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Primer quincena de Marzo' AS canal
    FROM ventas
    WHERE fecha_venta <  '2024-03-11'

    UNION ALL

    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Segunda quincena de Marzo' AS canal
    FROM ventas
    WHERE fecha_venta >= '2024-03-11'
) AS consolidado
GROUP BY canal;
GO