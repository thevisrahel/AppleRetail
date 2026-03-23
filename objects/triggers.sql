-- =====================================
-- TRIGGERS
-- =====================================
USE AppleRetailLabarca;

DELIMITER $$

-- =====================================
-- Trigger: Valida que la cantidad de venta sea mayor a 0
-- =====================================
CREATE TRIGGER trg_validate_quantity
BEFORE INSERT ON Sales
FOR EACH ROW
BEGIN
    IF NEW.quantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La cantidad debe ser mayor a 0';
    END IF;
END $$


-- =====================================
-- Trigger: Evita precios negativos en productos
-- =====================================
CREATE TRIGGER trg_validate_price
BEFORE INSERT ON Products
FOR EACH ROW
BEGIN
    IF NEW.price < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El precio no puede ser negativo';
    END IF;
END $$


-- =====================================
-- Trigger: Evita registrar ventas con fechas futuras
-- =====================================
CREATE TRIGGER trg_validate_sale_date
BEFORE INSERT ON Sales
FOR EACH ROW
BEGIN
    IF NEW.sale_date > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de venta no puede ser futura';
    END IF;
END $$


-- =====================================
-- Trigger: Valida que la fecha de garantía sea posterior a la venta
-- =====================================
CREATE TRIGGER trg_validate_warranty_date
BEFORE INSERT ON Warranty
FOR EACH ROW
BEGIN
    DECLARE saleDate DATE;

    SELECT sale_date INTO saleDate
    FROM Sales
    WHERE sale_id = NEW.sale_id;

    IF NEW.claim_date < saleDate THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La garantía no puede ser antes de la venta';
    END IF;
END $$


-- =====================================
-- Tabla: Almacena registros de auditoría de ventas
-- =====================================
CREATE TABLE IF NOT EXISTS Sales_Audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT,
    action_type VARCHAR(50),
    action_date DATETIME
) $$


-- =====================================
-- Trigger: Registra automáticamente cada venta en la tabla de auditoría
-- =====================================
CREATE TRIGGER trg_sales_audit
AFTER INSERT ON Sales
FOR EACH ROW
BEGIN
    INSERT INTO Sales_Audit (sale_id, action_type, action_date)
    VALUES (NEW.sale_id, 'INSERT', NOW());
END $$

DELIMITER ;