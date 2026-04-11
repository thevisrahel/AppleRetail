/*
====================================================
OBJETIVO:
Definir consultas SQL orientadas a KPIs clave del negocio
para el sistema Apple Retail Sales.
====================================================

KPI 1 — INGRESOS MENSUALES
----------------------------------------------------
MOTIVO:
Permite conocer cuánto dinero generan las ventas
en cada periodo de tiempo.

OBJETIVO:
Evaluar el rendimiento financiero mensual del negocio
y detectar tendencias de crecimiento o caída.

USO:
Ideal para reportes financieros y análisis temporal.
====================================================
*/

SELECT
    YEAR(s.sale_date) AS anio,
    MONTH(s.sale_date) AS mes,
    SUM(s.quantity * p.price) AS ingresos_totales
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY YEAR(s.sale_date), MONTH(s.sale_date)
ORDER BY anio, mes;

/*
====================================================
KPI 2 — PRODUCTOS MÁS VENDIDOS
----------------------------------------------------
MOTIVO:
Permite identificar qué productos tienen mayor
demanda dentro del negocio.

OBJETIVO:
Detectar productos estrella y apoyar decisiones
de inventario y marketing.

USO:
Análisis comercial y toma de decisiones estratégicas.
====================================================
*/

SELECT
    p.product_name,
    SUM(s.quantity) AS total_vendido
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_vendido DESC;

/*
====================================================
KPI 3 — VENTAS POR TIENDA
----------------------------------------------------
MOTIVO:
Permite analizar el desempeño de cada tienda.

OBJETIVO:
Comparar rendimiento entre ubicaciones y detectar
las más rentables.

USO:
Evaluación de desempeño comercial por tienda.
====================================================
*/

SELECT
    st.store_name,
    st.city,
    SUM(s.quantity * p.price) AS ingresos
FROM Sales s
JOIN Stores st ON s.store_id = st.store_id
JOIN Products p ON s.product_id = p.product_id
GROUP BY st.store_name, st.city
ORDER BY ingresos DESC;

/*
====================================================
KPI 4 — CLIENTES CON MAYOR CONSUMO
----------------------------------------------------
MOTIVO:
Permite identificar los clientes más importantes
para el negocio.

OBJETIVO:
Analizar patrones de compra y fidelización.

USO:
Segmentación de clientes y estrategias de marketing.
====================================================
*/

SELECT
    c.customer_name,
    SUM(s.quantity * p.price) AS total_compras
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
JOIN Products p ON s.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_compras DESC;

/*
====================================================
KPI 5 — TASA DE GARANTÍAS
----------------------------------------------------
MOTIVO:
Permite medir qué proporción de ventas genera
reclamos de garantía.

OBJETIVO:
Detectar problemas en productos o calidad.

USO:
Control de calidad y postventa.
====================================================
*/

SELECT
    COUNT(DISTINCT w.claim_id) AS total_garantias,
    COUNT(DISTINCT s.sale_id) AS total_ventas,
    (COUNT(DISTINCT w.claim_id) / COUNT(DISTINCT s.sale_id)) * 100 AS tasa_garantia
FROM Sales s
LEFT JOIN Warranty w ON s.sale_id = w.sale_id;