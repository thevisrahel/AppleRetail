-- Creación de base de datos
CREATE DATABASE AppleRetailLabarca;

USE AppleRetailLabarca;

-- Tabla Category
CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- Tabla Products
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

-- Tabla Stores
CREATE TABLE Stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(150) NOT NULL,
    city VARCHAR(100),
    country VARCHAR(100)
);

-- Tabla Sales
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE NOT NULL,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT fk_sales_store
        FOREIGN KEY (store_id)
        REFERENCES Stores(store_id),
    CONSTRAINT fk_sales_product
        FOREIGN KEY (product_id)
        REFERENCES Products(product_id)
);

-- Tabla Warranty
CREATE TABLE Warranty (
    claim_id INT PRIMARY KEY,
    claim_date DATE NOT NULL,
    sale_id INT NOT NULL,
    repair_status VARCHAR(100),
    CONSTRAINT fk_warranty_sale
        FOREIGN KEY (sale_id)
        REFERENCES Sales(sale_id)
);