-- Prepare a list of offices sorted by country, state, city.
SELECT * FROM classicmodels.offices
ORDER BY country, state, city

-- How many employees are there in the company?
select count(employeeNumber) FROM classicmodels.employees

-- What is the total of payments received?
select sum(amount) from classicmodels.payments

-- List the product lines that contain 'Cars'.
select productLine from classicmodels.productlines
where productLine LIKE "%Cars%"

-- Report total payments for October 28, 2004.
select sum(amount) from classicmodels.payments
where paymentDate = " 2004-10-28"

-- Report those payments greater than $100,000.
select * from classicmodels.payments
where amount > 100000

-- List the products in each product line.
select productLine, productName from classicmodels.products
order by productLine

-- How many products in each product line?
select productLine, count(productCode) as Total_Product from classicmodels.products
group by productLine

-- Report the account representative for each customer.
select c.customerName, e.firstName, e.lastName from classicmodels.customers c
left join classicmodels.employees e ON c.salesRepEmployeeNumber = e.employeeNumber

-- Report those payments greater than $100,000. Sort the report so the customer who made the highest payment appears first.
select p.checkNumber, p.paymentDate, p.amount, c.customerNumber, c.customerName 
from classicmodels.payments p
left join classicmodels.customers c ON p.customerNumber = c.customerNumber
where p.amount > 100000
order by p.amount DESC