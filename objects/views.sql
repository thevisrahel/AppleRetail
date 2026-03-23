-- =========================
-- VISTAS
-- =========================
USE AppleRetailLabarca;
-- =====================================
-- Vista: Detalle completo de ventas
-- =====================================
CREATE VIEW AppleRetailLabarca.vw_sales_detail AS
SELECT 
    s.sale_id,
    s.sale_date,
    c.customer_name,
    st.store_name,
    st.city,
    st.country,
    p.product_name,
    cat.category_name,
    pm.method_name AS payment_method,
    p.price,
    s.quantity
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
JOIN Stores st ON s.store_id = st.store_id
JOIN Products p ON s.product_id = p.product_id
JOIN Category cat ON p.category_id = cat.category_id
JOIN Payment_Methods pm ON s.payment_method_id = pm.payment_method_id;


-- =====================================
-- Vista: Total de productos vendidos
-- =====================================
CREATE VIEW AppleRetailLabarca.vw_sales_by_product AS
SELECT 
    p.product_name,
    SUM(s.quantity) AS total_sold
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name;


-- =====================================
-- Vista: Total de ventas por tienda
-- =====================================
CREATE VIEW AppleRetailLabarca.vw_sales_by_store AS
SELECT 
    st.store_name,
    st.city,
    SUM(s.quantity) AS total_sales
FROM Sales s
JOIN Stores st ON s.store_id = st.store_id
GROUP BY st.store_name, st.city;


-- =====================================
-- Vista: Productos con su categoría
-- =====================================
CREATE VIEW AppleRetailLabarca.vw_products_with_category AS
SELECT 
    p.product_id,
    p.product_name,
    cat.category_name,
    p.price,
    p.launch_date
FROM Products p
JOIN Category cat ON p.category_id = cat.category_id;


-- =====================================
-- Vista: Detalle de garantías
-- =====================================
CREATE VIEW AppleRetailLabarca.vw_warranty_detail AS
SELECT 
    w.claim_id,
    w.claim_date,
    ws.status_name,
    s.sale_id,
    p.product_name,
    st.store_name
FROM Warranty w
JOIN Warranty_Status ws ON w.status_id = ws.status_id
JOIN Sales s ON w.sale_id = s.sale_id
JOIN Products p ON s.product_id = p.product_id
JOIN Stores st ON s.store_id = st.store_id;


-- =====================================
-- Vista: Total monetario por venta
-- =====================================
CREATE VIEW AppleRetailLabarca.vw_sales_total AS
SELECT 
    s.sale_id,
    p.product_name,
    s.quantity,
    p.price,
    (s.quantity * p.price) AS total_amount
FROM Sales s
JOIN Products p ON s.product_id = p.product_id;