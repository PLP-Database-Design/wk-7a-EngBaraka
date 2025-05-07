Question 1 Achieving 1NF (First Normal Form) 🛠️
Task:

You are given the following table ProductDetail:
OrderID	CustomerName	Products
101	John Doe	Laptop, Mouse
102	Jane Smith	Tablet, Keyboard, Mouse
103	Emily Clark	Phone
In the table above, the Products column contains multiple values, which violates 1NF.
Write an SQL query to transform this table into 1NF, ensuring that each row represents a single product for an order
  -- Create a new table that represents a single product for each order
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Insert data by splitting the products into separate rows
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT OrderID, CustomerName, 'Laptop' AS Product FROM ProductDetail WHERE Products LIKE '%Laptop%'
UNION ALL
SELECT OrderID, CustomerName, 'Mouse' AS Product FROM ProductDetail WHERE Products LIKE '%Mouse%'
UNION ALL
SELECT OrderID, CustomerName, 'Tablet' AS Product FROM ProductDetail WHERE Products LIKE '%Tablet%'
UNION ALL
SELECT OrderID, CustomerName, 'Keyboard' AS Product FROM ProductDetail WHERE Products LIKE '%Keyboard%'
UNION ALL
SELECT OrderID, CustomerName, 'Phone' AS Product FROM ProductDetail WHERE Products LIKE '%Phone%';

Question 2 Achieving 2NF (Second Normal Form) 🧩
You are given the following table OrderDetails, which is already in 1NF but still contains partial dependencies:
OrderID	CustomerName	Product	Quantity
101	John Doe	Laptop	2
101	John Doe	Mouse	1
102	Jane Smith	Tablet	3
102	Jane Smith	Keyboard	1
102	Jane Smith	Mouse	2
103	Emily Clark	Phone	1
In the table above, the CustomerName column depends on OrderID (a partial dependency), which violates 2NF.

Write an SQL query to transform this table into 2NF by removing partial dependencies. Ensure that each non-key column fully depends on the entire primary key.
  -- Create a table for orders, removing the CustomerName column
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create a table for order details with no partial dependency
CREATE TABLE OrderDetails (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into the Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

-- Insert data into the OrderDetails table, excluding CustomerName
INSERT INTO OrderDetails (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;
