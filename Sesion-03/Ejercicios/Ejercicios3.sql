-- Para estas consultas usar INNER JOIN
-- Obtén la cantidad de productos de cada orden.
USE classicmodels;

SELECT orderNumber, sum(quantityOrdered) AS quantity_per_order
FROM orderdetails
JOIN products
	ON orderdetails.productCode = products.productCode
GROUP BY orderNumber
ORDER BY orderNumber;

-- Obtén el número de orden, estado y costo total de cada orden
SELECT od.orderNumber, sum(quantityOrdered*priceEach) AS Costo_total, ors.status
FROM orderdetails AS od
JOIN orders AS ors
	ON od.orderNumber = ors.orderNumber
GROUP BY orderNumber;

-- Obtén el número de orden, fecha de orden, línea de orden, nombre del producto, cantidad ordenada y precio de cada pieza.
SELECT od.orderNumber, orderDate, orderLineNumber, productName, quantityOrdered, priceEach
FROM orderdetails od
JOIN orders ors
	ON od.orderNumber = ors.orderNumber
JOIN products pr
	ON pr.productCode = od.productCode;
    
-- Obtén el número de orden, nombre del producto, el precio sugerido de fábrica (msrp) y precio de cada pieza.
SELECT orderNumber, productName, MSRP, priceEach
FROM products
JOIN orderdetails
	ON products.productCode = orderdetails.productCode;

-- LEFT JOIN
-- Obtén el número de cliente, nombre de cliente, número de orden y estado de cada orden hecha por cada cliente. ¿De qué nos sirve hacer LEFT JOIN en lugar de JOIN?
SELECT customers.customerNumber, customerName, orderNumber, status
FROM customers
LEFT JOIN orders
	ON customers.customerNumber = orders.customerNumber;
    -- Nos puede a ayudar a identificar a los clientes que no tienen ninguna orden, o al revés, las órdenes hechas para las cuales no se tiene un cliente asociado. 
    
-- Obtén los clientes que no tienen una orden asociada
SELECT customers.customerNumber, customerName, orderNumber, status
FROM customers
LEFT JOIN orders
	ON customers.customerNumber = orders.customerNumber
WHERE orderNumber = NULL;

-- Obtén el apellido de empleado, nombre de empleado, nombre de cliente, número de cheque y total, es decir, los clientes asociados a cada empleado.
SELECT concat(firstName, ' ', lastName) AS Employee_name, customerName, checkNumber, amount
FROM customers
LEFT JOIN employees
	ON customers.salesRepEmployeeNumber = employees.employeeNumber
LEFT JOIN payments
	ON customers.customerNumber = payments.customerNumber;

-- RIGHT JOIN
-- Obtén el número de cliente, nombre de cliente, número de orden y estado de cada orden hecha por cada cliente. ¿De qué nos sirve hacer LEFT JOIN en lugar de JOIN?
SELECT customers.customerNumber, customerName, orderNumber, status
FROM customers
RIGHT JOIN orders
	ON customers.customerNumber = orders.customerNumber;

-- Obtén los clientes que no tienen una orden asociada
SELECT customers.customerNumber, customerName, orderNumber, status
FROM customers
RIGHT JOIN orders
	ON customers.customerNumber = orders.customerNumber
WHERE orderNumber = NULL;

-- Obtén el apellido de empleado, nombre de empleado, nombre de cliente, número de cheque y total, es decir, los clientes asociados a cada empleado.
SELECT concat(firstName, ' ', lastName) AS Employee_name, customerName, checkNumber, amount
FROM customers
RIGHT JOIN employees
	ON customers.salesRepEmployeeNumber = employees.employeeNumber
RIGHT JOIN payments
	ON customers.customerNumber = payments.customerNumber;
 -- En los primeros dos casos de OUTER JOIN no hay diferencia porque no hay valores NULL y todos los registros tienen su valor correspondiente en ambas tablas, pero en el último, sólo mostró los customers a los cuales sí les corresponde un empleado. 

-- Escoge 3 consultas de los ejercicios anteriores, crea una vista y escribe una consulta para cada una.
CREATE VIEW cantidad_por_orden_354 AS
	(SELECT orderNumber, sum(quantityOrdered) AS quantity_per_order
	FROM orderdetails
	JOIN products
		ON orderdetails.productCode = products.productCode
	GROUP BY orderNumber
	ORDER BY orderNumber);

SELECT *
FROM cantidad_por_orden_354
ORDER BY orderNumber DESC
LIMIT 1;

CREATE VIEW orden_costo_estado_354 AS
	(SELECT od.orderNumber, sum(quantityOrdered*priceEach) AS Costo_total, ors.status
	FROM orderdetails AS od
	JOIN orders AS ors
		ON od.orderNumber = ors.orderNumber
	GROUP BY orderNumber);
    
SELECT *
FROM orden_costo_estado_354
WHERE NOT status='Shipped';

CREATE VIEW product_per_number_354 AS
	(SELECT od.orderNumber, orderDate, orderLineNumber, productName, quantityOrdered, priceEach
	FROM orderdetails od
	JOIN orders ors
		ON od.orderNumber = ors.orderNumber
	JOIN products pr
		ON pr.productCode = od.productCode);
        
SELECT *
FROM product_per_number_354
WHERE priceEach > 100;




