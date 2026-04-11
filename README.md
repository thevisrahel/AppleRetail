# Proyecto Final — Base de Datos Relacional

## Apple Retail Sales

---

## 1) Introducción

El presente proyecto consiste en el diseño e implementación de una base de datos relacional para la gestión de ventas en una tienda Apple Retail. El sistema permite registrar productos, categorías, tiendas, ventas y reclamos de garantía asociados a dichas ventas.

El modelo busca estructurar la información comercial de manera organizada, asegurando integridad referencial, consistencia de datos y escalabilidad para futuros módulos como clientes, métodos de pago o inventario.

---

## 2) Objetivo General

Organizar y gestionar de manera estructurada la información comercial de una tienda Apple Retail, permitiendo registrar productos, categorías, tiendas, ventas y garantías, con el fin de asegurar consistencia, trazabilidad y disponibilidad confiable de los datos.

---

## 3) Objetivos Específicos

* Centralizar la información de productos, ventas y garantías en un único sistema estructurado.
* Garantizar la coherencia entre las ventas realizadas y los reclamos de garantía asociados.
* Permitir el seguimiento de ventas por tienda, producto y fecha.
* Facilitar el control de productos según su categoría y precio.
* Asegurar que la información comercial pueda ser consultada de manera clara y organizada.

---

## 4) Problemática

Las operaciones comerciales de una tienda retail pueden generar grandes volúmenes de datos relacionados con productos, ventas y garantías. Si estos datos se almacenan en archivos planos o sistemas no estructurados:

* Se dificulta el control de ventas.
* No existe trazabilidad clara entre ventas y reclamos.
* Se generan inconsistencias.
* Se limita el análisis comercial.

La implementación de una base de datos relacional permite centralizar la información, reducir redundancia y mejorar la gestión operativa.

---

## 5) Modelo de Negocio

La organización modelada corresponde a una empresa retail dedicada a la venta de productos tecnológicos Apple.

El flujo básico del negocio es:

1. La empresa dispone de múltiples tiendas.
2. Cada tienda vende productos.
3. Los productos pertenecen a una categoría.
4. Cada venta registra fecha, tienda y producto vendido.
5. Algunas ventas pueden generar reclamos de garantía.

## 6) Vistas

### vw_sales_detail

**Descripción:** Muestra el detalle completo de cada venta realizada.
**Objetivo:** Permitir analizar ventas con toda la información relevante en una sola consulta (cliente, tienda, producto, categoría y método de pago).
**Tablas que la componen:**

* Sales
* Customers
* Stores
* Products
* Category
* Payment_Methods

### vw_sales_by_product

**Descripción:** Resume la cantidad total vendida por producto.
**Objetivo:** Identificar los productos más vendidos.
**Tablas:**

* Sales
* Products

### vw_sales_by_store

**Descripción:** Muestra el total de ventas por tienda.
**Objetivo:** Evaluar el rendimiento de cada tienda.
**Tablas:**

* Sales
* Stores

### vw_products_with_category

**Descripción:** Lista los productos junto con su categoría, precio y fecha de lanzamiento.
**Objetivo:** Facilitar la consulta de productos con su clasificación.
**Tablas:**

* Products
* Category

### vw_warranty_detail

**Descripción:** Muestra el detalle de reclamos de garantía.
**Objetivo:** Controlar el estado de las garantías y su relación con ventas y productos.
**Tablas:**

* Warranty
* Warranty_Status
* Sales
* Products
* Stores

### vw_sales_total

**Descripción:** Calcula el monto total por cada venta.
**Objetivo:** Evitar cálculos manuales y facilitar reportes financieros.
**Tablas:**

* Sales
* Products

---

## 7) Funciones

### fn_total_sale

**Descripción:** Calcula el total monetario de una venta específica.
**Objetivo:** Obtener rápidamente el monto total sin repetir cálculos.
**Tablas:**

* Sales
* Products

### fn_customer_total_purchases

**Descripción:** Suma la cantidad total de productos comprados por un cliente.
**Objetivo:** Medir el nivel de consumo de un cliente.
**Tabla:**

* Sales

### fn_warranty_count_by_sale

**Descripción:** Cuenta cuántos reclamos de garantía tiene una venta.
**Objetivo:** Detectar productos o ventas problemáticas.
**Tabla:**

* Warranty

### fn_total_sales_by_store

**Descripción:** Calcula el total de productos vendidos por una tienda.
**Objetivo:** Evaluar rendimiento comercial.
**Tabla:**

* Sales

---

## 8) Stored Procedures

### sp_register_sale

**Descripción:** Registra una nueva venta.
**Objetivo:** Centralizar el registro de ventas y evitar errores manuales.
**Tabla afectada:**

* Sales

### sp_register_warranty

**Descripción:** Registra un reclamo de garantía.
**Objetivo:** Gestionar garantías de manera estructurada.
**Tabla:**

* Warranty

### sp_update_warranty_status

**Descripción:** Actualiza el estado de una garantía.
**Objetivo:** Permitir el seguimiento del proceso de garantía.
**Tabla:**

* Warranty

### sp_sales_by_date_range

**Descripción:** Obtiene ventas entre dos fechas.
**Objetivo:** Generar reportes por periodos.
**Tabla:**

* Sales

### sp_sales_by_customer

**Descripción:** Obtiene ventas de un cliente específico.
**Objetivo:** Analizar historial de compras.
**Tabla:**

* Sales

---

## 9) Triggers

### trg_validate_quantity

**Descripción:** Este trigger se ejecuta antes de insertar un registro en la tabla Sales.
**Objetivo:** Validar que la cantidad de productos vendidos sea mayor a cero.
**Funcionamiento:** Si el valor de *quantity* es menor o igual a 0, el sistema genera un error e impide la inserción del registro.
**Tabla involucrada:**

* Sales

### trg_validate_price

**Descripción:** Se ejecuta antes de insertar un producto en la tabla Products.
**Objetivo:** Evitar que se registren productos con precios negativos.
**Funcionamiento:** Si el campo *price* es menor a 0, el trigger bloquea la operación.
**Tabla involucrada:**

* Products

### trg_validate_sale_date

**Descripción:** Se ejecuta antes de insertar una venta.
**Objetivo:** Asegurar que las ventas no tengan fechas futuras.
**Funcionamiento:** Si la fecha de venta (*sale_date*) es mayor a la fecha actual, se genera un error.
**Tabla involucrada:**

* Sales

### trg_validate_warranty_date

**Descripción:** Se ejecuta antes de insertar un reclamo de garantía.
**Objetivo:** Garantizar coherencia entre la fecha de venta y la fecha del reclamo.
**Funcionamiento:** El trigger obtiene la fecha de la venta asociada y verifica que la fecha del reclamo (*claim_date*) no sea anterior.
**Tablas involucradas:**

* Warranty
* Sales

### trg_sales_audit

**Descripción:** Se ejecuta después de insertar una venta.
**Objetivo:** Registrar automáticamente cada venta en una tabla de auditoría.
**Funcionamiento:** Cada vez que se inserta una venta, se guarda un registro en la tabla *Sales_Audit* con el ID de la venta, tipo de acción y fecha.
**Tablas involucradas:**

* Sales
* Sales_Audit
