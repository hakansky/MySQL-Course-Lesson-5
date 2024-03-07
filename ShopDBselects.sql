CREATE DATABASE IF NOT EXISTS ShopDB;

USE ShopDB;

DROP TABLE Customers;
DROP TABLE Employees;
DROP TABLE Orders;
DROP TABLE OrderDetails;
DROP TABLE Products;

CREATE TABLE IF NOT EXISTS Customers 
(
    CustomerID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Email VARCHAR(50),
    Phone VARCHAR(15),
    Address VARCHAR(50)
);

INSERT INTO Customers
(FirstName, LastName, Email, Phone, Address) 
VALUES
('Ivan', 'Ivanov', 'ivan@example.com', '+123456789', 'Lenina str., 1'),
('Maria', 'Petrova', 'maria@example.com', '+987654321', 'Pobedy avenue, 24');

CREATE TABLE IF NOT EXISTS Employees 
(
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Position VARCHAR(30) NOT NULL,
    Email VARCHAR(50),
    Phone VARCHAR(15),
    Address VARCHAR(50)
);

INSERT INTO Employees
(FirstName, LastName, Position, Email, Phone, Address)
VALUES
('Petro', 'Sidorov', 'Seller', 'peter@example.com', '+111111111', 'Pushkina str., 5'),
('Anna', 'Kuznetsova', 'Manager', 'anna@example.com', '+222222222', 'Svobody avenue, 31');

CREATE TABLE IF NOT EXISTS Products 
(
    ProductID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Description TEXT,
    Price DOUBLE(10, 2) NOT NULL
);

INSERT INTO Products
(Name, Description, Price)
VALUES
('T-Shirt', 'Size L, colour blue', 19.99),
('Jeans', 'Size 30/32, colour lack', 39.99),
('Sneakers', 'Size 10 US, colour white', 59.99);

CREATE TABLE IF NOT EXISTS Orders
(
    OrderID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    CustomerID INT NOT NULL,
    EmployeeID INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DOUBLE(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Orders
(CustomerID, EmployeeID, OrderDate, TotalAmount)
VALUES
(1, 1, '2024-03-01', 59.99),
(2, 2, '2024-03-02', 139.97);

CREATE TABLE IF NOT EXISTS OrderDetails
(
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DOUBLE(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails
(OrderID, ProductID, Quantity, Price)
VALUES
(1, 1, 1, 19.99),
(2, 2, 2, 39.99),
(2, 3, 1, 59.99);

SELECT * FROM Customers;
SELECT * FROM Employees;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM Products;

SELECT
    c.FirstName AS CustomerFN, c.LastName AS CustomerLN,
	e.FirstName AS EmployeeFN, e.LastName AS EmployeeLN,
    SUM(od.Quantity * p.Price) AS TotalPrice
FROM
    Orders o
    JOIN Customers c ON o.CustomerID = c.CustomerID
    JOIN Employees e ON o.EmployeeID = e.EmployeeID
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
GROUP BY
    o.OrderID
HAVING
    SUM(od.Quantity * p.Price) > 100;
