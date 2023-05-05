--Question 1--
--Create two tables, employees and sales. Get a list of all employees who did not make any sales  --
CREATE TABLE employees (
  employee_id INT PRIMARY KEY,
  employee_name VARCHAR(50),
  department VARCHAR(50),
  hire_date DATE
);

CREATE TABLE sales (
  sale_id INT PRIMARY KEY,
  employee_id INT,
  sale_date DATE,
  amount DECIMAL(10,2),
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO employees VALUES
  (1, 'John Doe', 'Sales', '2020-01-01'),
  (2, 'Jane Smith', 'Marketing', '2020-01-15'),
  (3, 'Bob Johnson', 'Sales', '2020-02-01'),
  (4, 'Mary Lee', 'Marketing', '2020-02-15');

INSERT INTO sales VALUES
  (1, 1, '2020-02-01', 1000.00),
  (2, 3, '2020-02-15', 500.00),
  (3, 3, '2020-03-01', 750.00);

-- Get a list of all employees who did not make any sales
SELECT employees.employee_id, employees.employee_name
FROM employees
LEFT JOIN sales ON employees.employee_id = sales.employee_id
WHERE sales.sale_id IS NULL;

--end of employees and sales query---
--end of Question 1--



--Question 2--
-- Assuming you have Customers table; with columns CustomerID, CustomerName, ContactName, Address, City, PostalCode and Country.--
--Write a query to list the number of customers in each country; only include countries with more than 3 customers and order in ascending order. --

---create table custoners--
CREATE TABLE Customers (
    CustomerID INT,
    CustomerName VARCHAR(50),
    ContactName VARCHAR(50),
    Address VARCHAR(50),
    City VARCHAR(50),
    PostalCode VARCHAR(10),
    Country VARCHAR(50)
);

-- insert sample data
INSERT INTO Customers VALUES
(1, 'Customer 1', 'Contact 1', 'Address 1', 'City 1', '10001', 'Country 1'),
(2, 'Customer 2', 'Contact 2', 'Address 2', 'City 2', '10002', 'Country 1'),
(3, 'Customer 3', 'Contact 3', 'Address 3', 'City 3', '10003', 'Country 1'),
(4, 'Customer 4', 'Contact 4', 'Address 4', 'City 4', '10004', 'Country 2'),
(5, 'Customer 5', 'Contact 5', 'Address 5', 'City 5', '10005', 'Country 2'),
(6, 'Customer 6', 'Contact 6', 'Address 6', 'City 6', '10006', 'Country 3'),
(7, 'Customer 7', 'Contact 7', 'Address 7', 'City 7', '10007', 'Country 3'),
(8, 'Customer 8', 'Contact 8', 'Address 8', 'City 8', '10008', 'Country 3'),
(9, 'Customer 9', 'Contact 9', 'Address 9', 'City 9', '10009', 'Country 3'),
(10, 'Customer 10', 'Contact 10', 'Address 10', 'City 10', '10010', 'Country 4');

-- list number of customers in each country with more than 3 customers
SELECT Country, COUNT(*) AS NumCustomers
FROM Customers
GROUP BY Country
HAVING COUNT(*) > 3
ORDER BY Country ASC;

--End of customers query--
--End of Question 2---




---Question 3---
--Write one procedure that can insert or update the employee (avoid using if statement to check the statement e.g., if (statement ==’Insert)) ---
---create table employee--
CREATE TABLE Employee (
    EmpId INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BirthDate DATE,
    Salary DECIMAL(18, 2)
);

--insert data--
INSERT INTO Employee VALUES
(1, 'John', 'Doe', '1990-01-01', 50000.00),
(2, 'Alice', 'Smith', '1985-05-10', 55000.00),
(3, 'Bob', 'Johnson', '1995-09-15', 45000.00);


--vreate procedure to insert or update employee--
CREATE PROCEDURE Insupemployee
    @EmpId INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @BirthDate DATE,
    @Salary DECIMAL(18, 2)
AS
BEGIN
    SET NOCOUNT ON;

    -- update employee if already exists
    UPDATE Employee
    SET FirstName = @FirstName,
        LastName = @LastName,
        BirthDate = @BirthDate,
        Salary = @Salary
    WHERE EmpId = @EmpId;

    -- insert new employee if does not exist
    INSERT INTO Employee (EmpId, FirstName, LastName, BirthDate, Salary)
    SELECT @EmpId, @FirstName, @LastName, @BirthDate, @Salary
    WHERE NOT EXISTS (SELECT 1 FROM Employee WHERE EmpId = @EmpId);
END;


-- insert a new employee with EmpId = 1
EXEC Insupemployee 1, 'John', 'Doe', '1990-01-01', 50000.00;

-- update the employee with EmpId = 1
EXEC Insupemployee 1, 'Jane', 'Doe', '1990-01-01', 55000.00;

-- verify that the employees were inserted/updated correctly
SELECT * FROM Employee;

--End of insert/update procedure---
---End of Question 3---




----Question 4--
--Write an SQL query to fetch duplicate records from an EmployeeDetails table (without considering the primary key – EmpId)(create dummy data to use) ---
-- create dummy data
CREATE TABLE EmployeeDetails (
  EmpId INT PRIMARY KEY,
  EmpName VARCHAR(50),
  EmpSalary DECIMAL(10,2),
  EmpDept VARCHAR(50)
);

INSERT INTO EmployeeDetails (EmpId, EmpName, EmpSalary, EmpDept)
VALUES 
(1, 'John', 50000.00, 'IT'),
(2, 'Jane', 60000.00, 'HR'),
(3, 'Bob', 55000.00, 'Sales'),
(4, 'Alice', 65000.00, 'IT'),
(5, 'Mike', 50000.00, 'HR'),
(6, 'Sarah', 60000.00, 'IT'),
(7, 'David', 55000.00, 'Sales'),
(8, 'Mary', 65000.00, 'HR'),
(9, 'John', 50000.00, 'IT'),
(10, 'Bob', 55000.00, 'Sales')
;

-- SQL query to fetch duplicate records
-- The HAVING clause is used to filter out groups with only one record and return duplicates--
SELECT EmpName, EmpSalary, EmpDept, COUNT(*) as DuplicateCount
FROM EmployeeDetails
GROUP BY EmpName, EmpSalary, EmpDept
HAVING COUNT(*) > 1;

----End of Question 4--




---Question 5--
--Write an SQL query to fetch only odd rows from the table (create dummy data to use) --

-- create dummy data
CREATE TABLE ExampleTable (
  id INT PRIMARY KEY IDENTITY(1,1),
  column1 VARCHAR(50),
  column2 VARCHAR(50)
);

INSERT INTO ExampleTable (column1, column2)
VALUES 
('row 1', 'data 1'),
('row 2', 'data 2'),
('row 3', 'data 3'),
('row 4', 'data 4'),
('row 5', 'data 5'),
('row 6', 'data 6'),
('row 7', 'data 7'),
('row 8', 'data 8')
;

-- SQL query to fetch odd rows
SELECT *
FROM ExampleTable
WHERE id % 2 = 1;

---End of Query--
---End of Question 5---



---Question 6---
---Write a function that can calculate age given a certain date of birth (06/06/2023 should output zero) ---

--creates a function named calculate age--
CREATE FUNCTION CalculateAge 
(
  @DateOfBirth DATE
)
RETURNS INT
AS
BEGIN
  DECLARE @Age INT;
  IF @DateOfBirth > GETDATE()
    SET @Age = 0;
  ELSE
    SET @Age = DATEDIFF(YEAR, @DateOfBirth, GETDATE()) - 
               CASE WHEN MONTH(@DateOfBirth) > MONTH(GETDATE()) 
                    OR (MONTH(@DateOfBirth) = MONTH(GETDATE()) AND DAY(@DateOfBirth) > DAY(GETDATE()))
                    THEN 1 ELSE 0 END;
  RETURN @Age;
END





--tests the with a future date to ensure it returns zero--
SELECT dbo.CalculateAge('2023-06-06') AS Age;

----End of Question 6---

