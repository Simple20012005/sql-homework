create database F33_homework16

use F33_homework16


CREATE TABLE Numbers1(Number INT)

INSERT INTO Numbers1 VALUES (5),(9),(8),(6),(7)

CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)
 
INSERT INTO FindSameCharacters VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')



CREATE TABLE RemoveDuplicateIntsFromNames
(
      PawanName INT
    , Pawan_slug_name VARCHAR(1000)
)
 
 
INSERT INTO RemoveDuplicateIntsFromNames VALUES
(1,  'PawanA-111'  ),
(2, 'PawanB-123'   ),
(3, 'PawanB-32'    ),
(4, 'PawanC-4444' ),
(5, 'PawanD-3'  )





CREATE TABLE Example
(
Id       INTEGER IDENTITY(1,1) PRIMARY KEY,
String VARCHAR(30) NOT NULL
);


INSERT INTO Example VALUES('123456789'),('abcdefghi');


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, DepartmentID, FirstName, LastName, Salary) VALUES
(1, 1, 'John', 'Doe', 60000.00),
(2, 1, 'Jane', 'Smith', 65000.00),
(3, 2, 'James', 'Brown', 70000.00),
(4, 3, 'Mary', 'Johnson', 75000.00),
(5, 4, 'Linda', 'Williams', 80000.00),
(6, 2, 'Michael', 'Jones', 85000.00),
(7, 1, 'Robert', 'Miller', 55000.00),
(8, 3, 'Patricia', 'Davis', 72000.00),
(9, 4, 'Jennifer', 'García', 77000.00),
(10, 1, 'William', 'Martínez', 69000.00);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'Marketing'),
(4, 'Finance'),
(5, 'IT'),
(6, 'Operations'),
(7, 'Customer Service'),
(8, 'R&D'),
(9, 'Legal'),
(10, 'Logistics');

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE
);
INSERT INTO Sales (SalesID, EmployeeID, ProductID, SalesAmount, SaleDate) VALUES
-- January 2025
(1, 1, 1, 1550.00, '2025-01-02'),
(2, 2, 2, 2050.00, '2025-01-04'),
(3, 3, 3, 1250.00, '2025-01-06'),
(4, 4, 4, 1850.00, '2025-01-08'),
(5, 5, 5, 2250.00, '2025-01-10'),
(6, 6, 6, 1450.00, '2025-01-12'),
(7, 7, 1, 2550.00, '2025-01-14'),
(8, 8, 2, 1750.00, '2025-01-16'),
(9, 9, 3, 1650.00, '2025-01-18'),
(10, 10, 4, 1950.00, '2025-01-20'),
(11, 1, 5, 2150.00, '2025-02-01'),
(12, 2, 6, 1350.00, '2025-02-03'),
(13, 3, 1, 2050.00, '2025-02-05'),
(14, 4, 2, 1850.00, '2025-02-07'),
(15, 5, 3, 1550.00, '2025-02-09'),
(16, 6, 4, 2250.00, '2025-02-11'),
(17, 7, 5, 1750.00, '2025-02-13'),
(18, 8, 6, 1650.00, '2025-02-15'),
(19, 9, 1, 2550.00, '2025-02-17'),
(20, 10, 2, 1850.00, '2025-02-19'),
(21, 1, 3, 1450.00, '2025-03-02'),
(22, 2, 4, 1950.00, '2025-03-05'),
(23, 3, 5, 2150.00, '2025-03-08'),
(24, 4, 6, 1700.00, '2025-03-11'),
(25, 5, 1, 1600.00, '2025-03-14'),
(26, 6, 2, 2050.00, '2025-03-17'),
(27, 7, 3, 2250.00, '2025-03-20'),
(28, 8, 4, 1350.00, '2025-03-23'),
(29, 9, 5, 2550.00, '2025-03-26'),
(30, 10, 6, 1850.00, '2025-03-29'),
(31, 1, 1, 2150.00, '2025-04-02'),
(32, 2, 2, 1750.00, '2025-04-05'),
(33, 3, 3, 1650.00, '2025-04-08'),
(34, 4, 4, 1950.00, '2025-04-11'),
(35, 5, 5, 2050.00, '2025-04-14'),
(36, 6, 6, 2250.00, '2025-04-17'),
(37, 7, 1, 2350.00, '2025-04-20'),
(38, 8, 2, 1800.00, '2025-04-23'),
(39, 9, 3, 1700.00, '2025-04-26'),
(40, 10, 4, 2000.00, '2025-04-29'),
(41, 1, 5, 2200.00, '2025-05-03'),
(42, 2, 6, 1650.00, '2025-05-07'),
(43, 3, 1, 2250.00, '2025-05-11'),
(44, 4, 2, 1800.00, '2025-05-15'),
(45, 5, 3, 1900.00, '2025-05-19'),
(46, 6, 4, 2000.00, '2025-05-23'),
(47, 7, 5, 2400.00, '2025-05-27'),
(48, 8, 6, 2450.00, '2025-05-31'),
(49, 9, 1, 2600.00, '2025-06-04'),
(50, 10, 2, 2050.00, '2025-06-08'),
(51, 1, 3, 1550.00, '2025-06-12'),
(52, 2, 4, 1850.00, '2025-06-16'),
(53, 3, 5, 1950.00, '2025-06-20'),
(54, 4, 6, 1900.00, '2025-06-24'),
(55, 5, 1, 2000.00, '2025-07-01'),
(56, 6, 2, 2100.00, '2025-07-05'),
(57, 7, 3, 2200.00, '2025-07-09'),
(58, 8, 4, 2300.00, '2025-07-13'),
(59, 9, 5, 2350.00, '2025-07-17'),
(60, 10, 6, 2450.00, '2025-08-01');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    CategoryID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, CategoryID, ProductName, Price) VALUES
(1, 1, 'Laptop', 1000.00),
(2, 1, 'Smartphone', 800.00),
(3, 2, 'Tablet', 500.00),
(4, 2, 'Monitor', 300.00),
(5, 3, 'Headphones', 150.00),
(6, 3, 'Mouse', 25.00),
(7, 4, 'Keyboard', 50.00),
(8, 4, 'Speaker', 200.00),
(9, 5, 'Smartwatch', 250.00),
(10, 5, 'Camera', 700.00);


--Easy Tasks

--1.Create a numbers table using a recursive query from 1 to 1000.

with Numbers as(
select 1 as n
union all
select n+1 from Numbers
where n<=1000)
select * from Numbers
OPTION (MAXRECURSION 0)

--2.Write a query to find the total sales per employee using a derived table.(Sales, Employees)

select * from Sales
select * from Employees

SELECT 
    e.FirstName,
    e.LastName,
    t.TotalSales
FROM Employees e
JOIN (
    SELECT 
        EmployeeID, 
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) AS t ON e.EmployeeID = t.EmployeeID;

--3.Create a CTE to find the average salary of employees.(Employees)

select * from Employees 
WITH Salary AS (
    SELECT AVG(Salary) as AvgSalary  FROM Employees
)
SELECT * FROM Salary;

--4.Write a query using a derived table to find the highest sales for each product.(Sales, Products)

select p.ProductName,t.Maxsalary from products p
join (select ProductID,max(SalesAmount) as Maxsalary from Sales
group by ProductID) as t on t.ProductID=p.ProductID

--5.Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.

with Numbers as(
select 1 as n
union all
select n*2  from Numbers
where n*2<=1000000)
select * from Numbers
OPTION (MAXRECURSION 0)


--6.Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)

with m1 as (select EmployeeID,count(salesid) as countsale from Sales
group by EmployeeID
having COUNT(SalesID)>5),
m2 as(select e.FirstName,m1.countsale from m1 
join Employees e on m1.EmployeeID=e.EmployeeID) 
select * from m2;

--7.Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)

with Total as(select ProductID,sum(SalesAmount) Totalsales from Sales group by ProductID having sum(SalesAmount)>500)
select t.productID,p.ProductName,t.Totalsales from Total t join Products p on p.ProductID= t.productID

--8.Create a CTE to find employees with salaries above the average salary.(Employees)

with m1 as(select avg(salary) as avgsalary from Employees),
m2 as(select e.EmployeeID,e.DepartmentID,e.FirstName,e.LastName,e.Salary from Employees e
join m1 on e.Salary>m1.avgsalary)
select * from m2

--Medium Tasks

--1.Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)

select top 5 e.FirstName,m1.countsale from employees e
join (select EmployeeID,count(salesid) as countsale from Sales
group by EmployeeID) m1 on m1.EmployeeID=e.EmployeeID
order by m1.countsale desc

--2.Write a query using a derived table to find the sales per product category.(Sales, Products)


select categoryid,sum(salesamount) from (select p.categoryid,s.SalesAmount from Sales s
join Products p on p.ProductID=s.ProductID) sub
group by CategoryID;

--3.Write a script to return the factorial of each value next to it.(Numbers1)

with factoial as(
select Number as n, Number as step,Number as num from Numbers1
union all 
select n*(step-1), step-1,num from factoial
where step>1)
select num,max(n) as Factoial from factoial
group by num;



--4.This script uses recursion to split a string into rows of substrings for each character in the string.(Example)

select * from Example;

with Num as(
select string,left((select string from example where id=1),1) as s,1 as n from Example
union all
select string,substring((select string from example where id=1),n+1,1),n+1 from num
where n<len(String)),
Num2 as(
select string,left((select string from example where id=2),1) as s,1 as n from Example
union all
select string,substring((select string from example where id=2),n+1,1),n+1 from num2
where n<len(String))
select distinct N1.s,N2.S 
from Num n1 
join num2 n2 on n1.n=n2.n ;


--5.Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)

with Totalsales as (select year(saledate) as Year, month(SaleDate) as month,sum(SalesAmount) as Totalsales  from Sales
group by year(saledate), MONTH(saledate)),
Difference as (select *,  Totalsales - LAG(Totalsales) OVER (ORDER BY year,month) AS DifferenceFromPreviousMonth from Totalsales)
select * from Difference

--6.Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)


select e.firstname,s.Year,s.Quarter,
s.Totalsales from employees e
join(select EmployeeID,
DATEPART(year,SaleDate) as Year,
DATEPART(quarter,SaleDate) as Quarter,
sum(salesamount) as Totalsales from Sales
group by  EmployeeID,
 DATEPART(year,SaleDate),DATEPART(quarter,SaleDate)
 having sum(salesamount)>45000) s on e.EmployeeID=s.EmployeeID

 --Difficult Tasks

--1.This script uses recursion to calculate Fibonacci numbers

WITH Fibonacci (n, fib_n, fib_n1) AS (
    SELECT 0, 0, 1
    UNION ALL
    SELECT n + 1, fib_n1, fib_n + fib_n1
    FROM Fibonacci
    WHERE n < 10
)
SELECT n, fib_n AS FibonacciNumber
FROM Fibonacci
ORDER BY n;


--2.Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)

select * from FindSameCharacters
select vals,case
when Vals is null then 'NULL'
when len(REPLACE(vals,left(vals,1),''))=0 then 'Bir hil belgi'
else 'Har hil belgi' 
end as Rusult
from FindSameCharacters;

--3.Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.
--(Example:n=5 | 1, 12, 123, 1234, 12345)

with Numbers as(
select cast('1' as varchar(200)) as n,1 as m
union all
select cast(n+cast(m+1 as varchar(200)) as varchar(200)),m+1 from Numbers
where m<50)
select * from Numbers

--4.Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)

select e.firstname,d.Totalsales from employees e
join(select EmployeeID,sum (SalesAmount) as Totalsales from (select *,DATEADD(MONTH,-6,SaleDate) a from Sales
where SaleDate>( select DATEADD(MONTH,-6,max(saledate))  from Sales )) inner_sub
group by EmployeeID) d on e.EmployeeID=d.EmployeeID
order by Totalsales desc


--5.Write a T-SQL query to remove the duplicate integer values present in the string column.
--Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)

SELECT REPLACE(
    TRANSLATE(Pawan_slug_name, '0123456789', '          '),  -- 10 ta bo‘sh joy
    ' ',
    ''
)
FROM RemoveDuplicateIntsFromNames
