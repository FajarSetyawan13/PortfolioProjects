-- Exercise Single Entity MySQL
-- What is the average percentage markup of the MSRP on buyPrice?
SELECT AVG((MSRP - buyPrice)/buyPrice) as average_markup FROM classicmodels.products

-- How many distinct products does ClassicModels sell?
SELECT COUNT(DISTINCT productName) as distinct_product FROM classicmodels.products

-- Report the name and city of customers who don't have sales representatives?
SELECT customerName, city FROM classicmodels.customers
WHERE salesRepEmployeeNumber is Null

-- What are the names of executives with VP or Manager in their title? Use the CONCAT function to combine the employee's first name and last name into a single field for reporting.
SELECT CONCAT(firstName, " ", lastName) as Name, jobTitle FROM classicmodels.employees
WHERE jobTitle LIKE "%VP%" or jobTitle LIKE "%Manager%"

-- Which orders have a value greater than $5,000?
select *, priceEach*quantityOrdered as value from classicmodels.orderdetails
where priceEach*quantityOrdered > 5000
Order by value ASC


## Exercise One to Many Relationship MySQL
-- Report total payments for Atelier graphique.
SELECT c.customerName, sum(p.amount) as total_payments
FROM classicmodels.customers c
LEFT JOIN classicmodels.payments p ON c.customerNumber = p.customerNumber
WHERE c.customerName = "Atelier graphique"

-- Report the products that have not been sold.
SELECT p.productCode, p.productName
FROM classicmodels.products p
LEFT JOIN classicmodels.orderdetails o ON p.productCode = o.productCode
WHERE o.orderNumber IS NULL

-- List the amount paid by each customer.
SELECT c.customerNumber, c.customerName, sum(p.amount) as total_payments
FROM classicmodels.customers c
LEFT JOIN classicmodels.payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber
ORDER BY c.customerNumber ASC

-- How many orders have been placed by Herkku Gifts?
SELECT c.customerNumber, c.customerName, COUNT(o.orderNumber) as total_order
FROM classicmodels.customers c
LEFT JOIN classicmodels.orders o ON c.customerNumber = o.customerNumber
WHERE c.customerName = "Herkku Gifts"
GROUP BY c.customerNumber

-- Who are the employees in Boston?
SELECT e.lastName, e.firstName, o.city
FROM classicmodels.offices o
LEFT JOIN classicmodels.employees e ON o.officeCode = e.officeCode
WHERE o.city = "Boston"


## Exercise Many to Many Relationship MySQL
-- List products sold by order date
SELECT p.productName, o.orderDate FROM classicmodels.products p
INNER JOIN classicmodels.orderdetails od ON p.productCode = od.productCode
INNER JOIN classicmodels.orders o ON o.orderNumber = od.orderNumber

-- List the order dates in descending order for orders for the 1940 Ford Pickup Truck.
SELECT p.productName, o.orderDate FROM classicmodels.products p
INNER JOIN classicmodels.orderdetails od ON p.productCode = od.productCode
INNER join classicmodels.orders o ON o.orderNumber = od.orderNumber
WHERE p.productName = "1940 Ford Pickup Truck"
ORDER BY o.orderDate DESC

-- List the names of customers and their corresponding order number where a particular order from that customer has a value greater than $25,000?
SELECT c.customerName, o.orderNumber, p.amount FROM classicmodels.customers c 
INNER JOIN classicmodels.orders o ON c.customerNumber = o.customerNumber 
LEFT JOIN classicmodels.payments p ON o.customerNumber = p.customerNumber 
WHERE p.amount > 25000

