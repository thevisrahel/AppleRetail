-- =========================
-- FUNCIONES
-- =========================
USE AppleRetailLabarca;
-- =====================================
-- Función: Calcula el total monetario de una venta
-- =====================================
DELIMITER $$

CREATE FUNCTION AppleRetailLabarca.fn_total_sale(p_sale_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT (s.quantity * p.price)
    INTO total
    FROM Sales s
    JOIN Products p ON s.product_id = p.product_id
    WHERE s.sale_id = p_sale_id;

    RETURN IFNULL(total,0);
END $$

DELIMITER ;


-- =====================================
-- Función: Total de productos comprados por cliente
-- =====================================
DELIMITER $$

CREATE FUNCTION AppleRetailLabarca.fn_customer_total_purchases(p_customer_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT SUM(quantity)
    INTO total
    FROM Sales
    WHERE customer_id = p_customer_id;

    RETURN IFNULL(total,0);
END $$

DELIMITER ;


-- =====================================
-- Función: Cantidad de garantías por venta
-- =====================================
DELIMITER $$

CREATE FUNCTION AppleRetailLabarca.fn_warranty_count_by_sale(p_sale_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COUNT(*)
    INTO total
    FROM Warranty
    WHERE sale_id = p_sale_id;

    RETURN total;
END $$

DELIMITER ;


-- =====================================
-- Función: Total de productos vendidos por tienda
-- =====================================
DELIMITER $$

CREATE FUNCTION AppleRetailLabarca.fn_total_sales_by_store(p_store_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT SUM(quantity)
    INTO total
    FROM Sales
    WHERE store_id = p_store_id;

    RETURN IFNULL(total,0);
END $$

DELIMITER ;