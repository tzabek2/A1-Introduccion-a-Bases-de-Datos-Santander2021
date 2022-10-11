-- Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyo nombre empiece con A.
USE classicmodels;
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName LIKE 'A%';

-- Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyo apellido termina con on.
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE lastName LIKE '%on';

-- Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyo nombre incluye la cadena on.
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE lastName LIKE '%on%';

-- Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyos nombres tienen seis letras e inician con G.
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE lastName LIKE 'G_____';

-- Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyo nombre no inicia con B
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE lastName NOT LIKE 'B%';

-- Dentro de la tabla products, obtén el código de producto y nombre de los productos cuyo código incluye la cadena _20
SELECT productCode, productName
FROM products
WHERE productCode LIKE '%?_20%' ESCAPE '?';

-- Dentro de la tabla orderdetails, obtén el total de cada orden
SELECT orderNumber, sum(priceEach) AS total
FROM orderdetails
GROUP BY orderNumber;

-- Dentro de la tabla orders obtén el número de órdenes por año
SELECT year(orderDate) AS 'Year'
      , count(*) TotalOrders
FROM orders
GROUP BY YEAR(orderDate);

-- Obtén el apellido y nombre de los empleados cuya oficina está ubicada en USA.
SELECT lastName, firstName
FROM employees e
WHERE e.officeCode IN (SELECT officeCode FROM offices WHERE country = 'USA');

-- Obtén el número de cliente, número de cheque y cantidad del cliente que ha realizado el pago más alto
SELECT customerNumber, checkNumber, amount
FROM payments
ORDER BY amount DESC
LIMIT 1;

SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount = (SELECT max(amount) FROM payments);

-- Obtén el número de cliente, número de cheque y cantidad de aquellos clientes cuyo pago es más alto que el promedio
SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount > (SELECT avg(amount) FROM payments);

-- Obtén el nombre de aquellos clientes que no han hecho ninguna orden
SELECT customerName
FROM customers
WHERE customerNumber NOT IN (SELECT customerNumber FROM payments);

-- Obtén el máximo, mínimo y promedio del número de productos en las órdenes de venta
SELECT max(number_of_products) AS Maximo, min(number_of_products) AS Minimo, avg(number_of_products) AS Promedio
FROM(
SELECT orderNumber, sum(quantityOrdered) AS number_of_products
FROM orderdetails
GROUP BY orderNumber) AS subconsulta;

SELECT max(quantityOrdered), min(quantityOrdered), avg(quantityOrdered)
FROM orderdetails;

-- Dentro de la tabla orders, Obtén el número de órdenes que hay por cada estado.
SELECT (SELECT state
	FROM customers
	WHERE customers.customerNumber = orders.customerNumber) AS states, count(*) AS cantidad_ordenes
FROM orders
GROUP BY states;



