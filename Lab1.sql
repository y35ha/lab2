/*Select all of the customers who live in NY state.  Show id, name, city and state.  Sort in a reasonable way.*/
SELECT CustomerID, Name, City, State 
FROM Customers 
WHERE State = 'NY'
ORDER BY City;

/*Select all of the states that start with A .  Show both code and name.  Sort by name.*/
SELECT ZipCode, Name 
FROM Customers
WHERE State LIKE 'A%'
ORDER BY Name;

/*Select all of the Products that have a price between 50 and 60 dollars.  Show code, description, price and quantity.*/
SELECT ProductCode, Description, UnitPrice, OnHandQuantity 
FROM Products 
WHERE UnitPrice BETWEEN 50 AND 60
ORDER BY UnitPrice; 

/*Get the value of the inventory that we have on hand for each product.  Show code, description, price, quantity and value.  Sort by value.*/
SELECT ProductCode, Description, UnitPrice, OnHandQuantity, OnHandQuantity * UnitPrice AS Value 
FROM Products
ORDER BY Value;

/*Get me a list of the invoices.  Show invoice id, customerid, invoice month as a number, invoice month as a word, invoice year.  Sort by year and month number. */
SELECT InvoiceID, CustomerID, month(invoicedate) AS MonthNumber, monthname(invoicedate) AS Month, year(invoicedate) as Year
FROM Invoices 
ORDER BY Year and MonthNumber;

/*Get me all of the information for the following products:  A4CS, ADC4, CS10*/
SELECT *
FROM Products 
WHERE ProductCode IN ('A4CS','ADC4','CS10');

/*Add the name of the state to the result set from #1 */
SELECT CustomerID, City, State, StateName 
FROM Customers JOIN States 
ON Customers.State = States.StateCode
WHERE State = 'NY'
ORDER BY City;

/*Add the customer's name to the result set from #5 */
SELECT InvoiceID, Invoices.CustomerID, month(invoicedate) AS MonthNumber, monthname(invoicedate) AS Month, year(invoicedate) as Year, Name 
FROM Invoices JOIN Customers 
ON Invoices.CustomerID = Customers.CustomerID
ORDER BY Year AND MonthNumber;

/*Get me a list of all of the products that have been ordered.  Show all of the product information as well as the invoice id and the quantity ordered on each invoice.  */
SELECT Products.ProductCode, Description, Products.UnitPrice, OnHandQuantity, InvoiceID, Quantity
FROM Products JOIN InvoiceLineItems 
ON Products.ProductCode = InvoiceLineItems.ProductCode 
ORDER BY ProductCode;

/*Get me a list of all of the invoices.  Show this invoiceid, customerid and invoicedate as well as the productcode, description, unitprice and quantity for each product ordered on the invoice.  You'll have more than one record for each invoice. */
SELECT Invoices.InvoiceID, CustomerID, InvoiceDate, Products.ProductCode, Description, Products.UnitPrice, Quantity 
FROM Products JOIN InvoiceLineItems ON Products.ProductCode = InvoiceLineItems.ProductCode 
JOIN Invoices ON InvoiceLineItems.InvoiceID = Invoices.InvoiceID
ORDER BY Invoices.InvoiceID;

/*Add the customer's name and statecode to the results from #10.  */
SELECT Invoices.InvoiceID, Customers.CustomerID, Name, StateCode, InvoiceDate, Products.ProductCode, Description, Products.UnitPrice, Quantity 
FROM Products JOIN InvoiceLineItems ON Products.ProductCode = InvoiceLineItems.ProductCode 
JOIN Invoices ON InvoiceLineItems.InvoiceID = Invoices.InvoiceID
JOIN Customers ON Customers.CustomerID = Invoices.CustomerID
JOIN States ON Customers.State = States.StateCode 
ORDER BY Invoices.InvoiceID;

/*Add the name of the state to the results from #11. */
SELECT Invoices.InvoiceID, Customers.CustomerID, Name, StateName, StateCode, InvoiceDate, Products.ProductCode, Description, Products.UnitPrice, Quantity 
FROM Products JOIN InvoiceLineItems ON Products.ProductCode = InvoiceLineItems.ProductCode 
JOIN Invoices ON InvoiceLineItems.InvoiceID = Invoices.InvoiceID
JOIN Customers ON Customers.CustomerID = Invoices.CustomerID
JOIN States ON Customers.State = States.StateCode 
ORDER BY Invoices.InvoiceID;

/*How many products do we have?*/
SELECT COUNT(*)
FROM Products;

/*How many customers do we have?*/
SELECT COUNT(*)
FROM Customers;

/*What's the total value of all of the products we have on hand?*/
SELECT SUM(UnitPrice * OnHandQuantity) AS TotalValue 
FROM Products;

/*What's the total value of ALL of the products we have sold?  Use the itemtotal from invoicelineitems to do the calculation.*/
SELECT SUM(ItemTotal) AS TotalValue 
FROM InvoiceLineItems;

/*What's the total value of EACH products we have sold?  Use the itemtotal from invoicelineitems to do the calculation.  Show the productcode as well as the total for that product.*/
SELECT ProductCode, SUM(ItemTotal) AS TotalValue 
FROM InvoiceLineItems 
GROUP BY ProductCode; 

/*Add the product description to #17. */
SELECT Products.ProductCode, Description, SUM(ItemTotal) AS TotalValue 
FROM InvoiceLineItems JOIN Products 
ON InvoiceLineItems.ProductCode = Products.ProductCode 
GROUP BY Products.ProductCode, Description; 

/*How many orders (invoices) has each customer placed?  Show customerid, name and count. */
SELECT Customers.CustomerID, Name, COUNT(*) AS Orders  
FROM Customers JOIN Invoices
ON Customers.CustomerID = Invoices.CustomerID
GROUP BY Customers.CustomerID, Name
ORDER BY Customers.CustomerID;

/*List all customers, even if they don't have any orders.  Show customerid, name and count of orders (invoices).*/
SELECT Customers.CustomerID, Name, COUNT(IFNULL(InvoiceID, 1)) AS Orders
FROM Customers JOIN Invoices
ON Customers.CustomerID = Invoices.CustomerID
GROUP BY Customers.CustomerID, Name
ORDER BY Customers.CustomerID;


