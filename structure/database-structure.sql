-- Creación de base de datos
CREATE DATABASE AppleRetailLabarca;

USE AppleRetailLabarca;

-- =========================
-- Tabla Category
-- =========================
CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- =========================
-- Tabla Products
-- =========================
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    launch_date DATE,
    price DECIMAL(10,2),
    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id)
        REFERENCES Category(category_id)
);

-- =========================
-- Tabla Stores
-- =========================
CREATE TABLE Stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(150) NOT NULL,
    city VARCHAR(100),
    country VARCHAR(100)
);

-- =========================
-- Tabla Customers
-- =========================
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    phone VARCHAR(50)
);

-- =========================
-- Tabla Payment Methods
-- =========================
CREATE TABLE Payment_Methods (
    payment_method_id INT PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL
);

-- =========================
-- Tabla Sales
-- =========================
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE NOT NULL,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    payment_method_id INT NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT fk_sales_store
        FOREIGN KEY (store_id)
        REFERENCES Stores(store_id),
    CONSTRAINT fk_sales_product
        FOREIGN KEY (product_id)
        REFERENCES Products(product_id),
    CONSTRAINT fk_sales_customer
        FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id),
    CONSTRAINT fk_sales_payment
        FOREIGN KEY (payment_method_id)
        REFERENCES Payment_Methods(payment_method_id)
);

-- =========================
-- Tabla Warranty Status
-- =========================
CREATE TABLE Warranty_Status (
    status_id INT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- =========================
-- Tabla Warranty
-- =========================
CREATE TABLE Warranty (
    claim_id INT PRIMARY KEY,
    claim_date DATE NOT NULL,
    sale_id INT NOT NULL,
    status_id INT NOT NULL,
    CONSTRAINT fk_warranty_sale
        FOREIGN KEY (sale_id)
        REFERENCES Sales(sale_id),
    CONSTRAINT fk_warranty_status
        FOREIGN KEY (status_id)
        REFERENCES Warranty_Status(status_id)
);
