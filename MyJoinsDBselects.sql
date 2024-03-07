CREATE DATABASE IF NOT EXISTS MyJoinsDB;

USE MyJoinsDB;

CREATE TABLE IF NOT EXISTS Employees
(
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name VARCHAR (20) NOT NULL,
    phone VARCHAR (20) 
);

INSERT INTO Employees
(name, phone)
VALUES
('Daniel', '+380555555555'),
('John', '+380999999999'),
('Mike', '+380666666666'),
('Nick', '+380955555555'),
('Peter', '+380505050505');

SELECT * FROM Employees;

CREATE TABLE IF NOT EXISTS Employment
(
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    employeeID INT NOT NULL,
    salary INT NOT NULL,
    position VARCHAR (20),
    FOREIGN KEY (employeeID) REFERENCES Employees(id)
);

INSERT INTO Employment
(employeeID, salary, position)
VALUES
(1, 7000, 'Director'),
(2, 5000, 'Manager'),
(3, 3000, 'Worker'),
(4, 3000, 'Worker'),
(5, 2000, 'Worker');

SELECT * FROM Employment;

CREATE TABLE IF NOT EXISTS EmployeesInfo
(
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    employeeID INT NOT NULL,
    familyStatus VARCHAR (15),
    birthday DATE NOT NULL,
    city VARCHAR (15) NOT NULL,
    FOREIGN KEY (employeeID) REFERENCES Employees(id)
);

INSERT INTO EmployeesInfo
(employeeID, familyStatus, birthday, city)
VALUES
(1, 'Married', '1983-02-15', 'London'),
(2, 'Single', '1991-05-21', 'Paris'),
(3, 'Single', '1995-11-11', 'Copenhagen'),
(4, 'Married', '1987-01-25', 'Madrid'),
(5, 'Single', '1992-06-07', 'Berlin');

SELECT * FROM EmployeesInfo;

SELECT e.name, e.phone, ei.city
FROM Employees e
JOIN (
    SELECT employeeID, city
    FROM EmployeesInfo
) ei ON e.id = ei.employeeID;

SELECT e.name, e.phone, ei.birthday
FROM Employees e
JOIN (
    SELECT employeeID, birthday
    FROM EmployeesInfo
    WHERE familyStatus = 'Single'
) ei ON e.id = ei.employeeID;

SELECT e.name, e.phone, ei.birthday
FROM Employees e
JOIN (
    SELECT employeeID
    FROM Employment
    WHERE position = 'Manager'
) em ON e.id = em.employeeID
JOIN EmployeesInfo ei ON e.id = ei.employeeID;

