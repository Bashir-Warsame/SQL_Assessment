/* SQL FINAL ASSESSMENT PART 2 QUESTIONS 

Task 1: Can you insert a new record into the database,
 while ensuring ID's align with other tables?
 
 INSERT INTO customers (CustomerID, FirstName, LastName) VALUES (1994, 'Bashir', 'Warsame');

Task 2: 

A new customer has made an account, please can you add their data into the database?  

INSERT INTO customers (CustomerID, FirstName, LastName) VALUES (1994, 'Bashir', 'Warsame');

It turns out they were a customer previously, 
but they registered with the incorrectname, please remove their old records. 

DELETE FROM customers
WHERE CustomerID = 1994;

A different customer has been married recently; 
please could you change their surname to their new married surname? 

UPDATE customers
SET LastName = 'Jacobs'
WHERE CustomerID = 1993;

//check the changes like this// 
select *
from adventure_works.customers
where CustomerID = 1993;

Task 3: 
The CEO wants to see a list of all our customers’ full names,
please ensure this is only returned as a single table column.
Label the columns accordingly (alias). 

SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM customers;

Task 4:
Analyse the data to discover the top and bottom 5 Customers,
Salespeople, Countries, and Products. Feel free to include any other analysis that you
also feel would be beneficial for management to see.
Use joins to cross-reference the different table fields together. 



SELECT CONCAT(FirstName, ' ', LastName) AS CustomerName, SUM(TotalDue) AS TotalSpent
FROM customers
JOIN orders ON customers.CustomerID = orders.CustomerID
GROUP BY CustomerName
ORDER BY TotalSpent DESC
LIMIT 5;


SELECT CONCAT(FirstName, ' ', LastName) AS Salesperson, SUM(TotalDue) AS TotalSales
FROM employees
JOIN orders ON employees.EmployeeID = orders.EmployeeID
GROUP BY Salesperson
ORDER BY TotalSales DESC
LIMIT 5;

SELECT Country, SUM(TotalDue) AS TotalSales
FROM employees
JOIN orders ON employees.EmployeeID = orders.EmployeeID
JOIN customers ON orders.CustomerID = customers.CustomerID
GROUP BY Country
ORDER BY TotalSales DESC
LIMIT 5;


SELECT ProductName, SUM(OrderQty) AS TotalSales
FROM products
JOIN orders ON products.ProductID = orders.ProductID
GROUP BY ProductName
ORDER BY TotalSales DESC
LIMIT 5;
 
//Change Order to ASC to view bottom 5//

Task 5:
Find some interesting attributes in the customer data – i.e.,
 the number of customers whose names begin with ‘a’. 
 
 SELECT COUNT(*) AS CountCustomersWithA
FROM customers
WHERE FirstName LIKE 'A%';
 
Task 6: 

The Analytics Team Leader needs one of your queries to be a stored
procedure to speed up their analysis when presenting to leadership.
(You have the freedom to choose what your stored procedure will do) Bonus Point:
If they can explain why they chose the query they did and how this will help the TL. 

// create a stored procedure that calculates the total sales amount for a given country.
This stored procedure will accept a parameter for the country name and
 return the total sales amount for that country. 
 
 
DELIMITER //

CREATE PROCEDURE GetTotalSalesForCountry (IN countryName VARCHAR(100), OUT totalSales DECIMAL(10, 2))
BEGIN
    SELECT SUM(orders.TotalDue) INTO totalSales
    FROM orders
    JOIN customers ON orders.CustomerID = customers.CustomerID
    JOIN employees ON orders.EmployeeID = employees.EmployeeID
    WHERE customers.Country = countryName;
END //

DELIMITER ;

Task 7:

Your fellow data analysts on your team have been complaining about
the slow performance of one of their join queries;
can you find a way to speed up the process of query completion? 

Use Indexes: Ensure that all columns involved in join conditions and filtering
have appropriate indexes. Indexes help the database engine locate rows more efficiently.


Task 8:
Create a trigger to improve our data updating processes. 

///

*/





