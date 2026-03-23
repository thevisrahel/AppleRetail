-- =========================
-- STORED PROCEDURES
-- =========================
USE AppleRetailLabarca;

DELIMITER $$

-- =====================================
-- Procedimiento: Registra una nueva venta
-- =====================================
CREATE PROCEDURE AppleRetailLabarca.sp_register_sale (
    IN p_sale_id INT,
    IN p_sale_date DATE,
    IN p_store_id INT,
    IN p_product_id INT,
    IN p_customer_id INT,
    IN p_payment_method_id INT,
    IN p_quantity INT
)
BEGIN
    INSERT INTO Sales (
        sale_id, sale_date, store_id, product_id, customer_id, payment_method_id, quantity
    )
    VALUES (
        p_sale_id, p_sale_date, p_store_id, p_product_id, p_customer_id, p_payment_method_id, p_quantity
    );
END $$


-- =====================================
-- Procedimiento: Registra un reclamo de garantía
-- =====================================
CREATE PROCEDURE AppleRetailLabarca.sp_register_warranty (
    IN p_claim_id INT,
    IN p_claim_date DATE,
    IN p_sale_id INT,
    IN p_status_id INT
)
BEGIN
    INSERT INTO Warranty (
        claim_id, claim_date, sale_id, status_id
    )
    VALUES (
        p_claim_id, p_claim_date, p_sale_id, p_status_id
    );
END $$


-- =====================================
-- Procedimiento: Actualiza el estado de una garantía
-- =====================================
CREATE PROCEDURE AppleRetailLabarca.sp_update_warranty_status (
    IN p_claim_id INT,
    IN p_status_id INT
)
BEGIN
    UPDATE Warranty
    SET status_id = p_status_id
    WHERE claim_id = p_claim_id;
END $$


-- =====================================
-- Procedimiento: Obtiene ventas entre dos fechas
-- =====================================
CREATE PROCEDURE AppleRetailLabarca.sp_sales_by_date_range (
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    SELECT *
    FROM Sales
    WHERE sale_date BETWEEN p_start_date AND p_end_date;
END $$


-- =====================================
-- Procedimiento: Obtiene ventas de un cliente específico
-- =====================================
CREATE PROCEDURE AppleRetailLabarca.sp_sales_by_customer (
    IN p_customer_id INT
)
BEGIN
    SELECT *
    FROM Sales
    WHERE customer_id = p_customer_id;
END $$

DELIMITER ;