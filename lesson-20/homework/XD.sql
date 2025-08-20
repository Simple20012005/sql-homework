create database F33_homework20

use F33_homework20

CREATE TABLE #Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);


INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES
('Alice', 'Laptop', 1, 1200.00, '2024-01-15'),
('Bob', 'Smartphone', 2, 800.00, '2024-02-10'),
('Charlie', 'Tablet', 1, 500.00, '2024-02-20'),
('David', 'Laptop', 1, 1300.00, '2024-03-05'),
('Eve', 'Smartphone', 3, 750.00, '2024-03-12'),
('Frank', 'Headphones', 2, 100.00, '2024-04-08'),
('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'),
('Hannah', 'Tablet', 2, 480.00, '2024-05-05'),
('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'),
('Jack', 'Smartphone', 1, 820.00, '2024-06-01');

set language english
--1. Find customers who purchased at least one item in March 2024 using EXISTS

select distinct customername from #Sales c
where exists (select 1 from #Sales s where 
c.CustomerName=s.CustomerName and
SaleDate >= '2024-03-01'
      AND SaleDate <  '2024-04-01')

--2. Find the product with the highest total sales revenue using a subquery.

select Product,sum(Quantity*Price) TotalRevenue from #Sales
group by Product
having sum(Quantity*Price)=(select max(TotalRevenue) from (select Product,sum(Quantity*Price) TotalRevenue from #Sales
group by Product
) sub)


--3. Find the second highest sale amount using a subquery

SELECT MAX(SaleAmount) AS SecondHighestSale
FROM (
    SELECT Quantity * Price AS SaleAmount
    FROM #Sales
) AS t
WHERE SaleAmount < (
    SELECT MAX(Quantity * Price) 
    FROM #Sales
);


--4. Find the total quantity of products sold per month using a subquery

SELECT SaleMonth, SUM(Quantity) AS TotalQuantity
FROM (
    SELECT 
        MONTH(SaleDate) AS SaleMonth,
        Quantity
    FROM #Sales
) AS t
GROUP BY SaleMonth;


--5. Find customers who bought same products as another customer using EXISTS

SELECT DISTINCT s1.CustomerName, s1.Product
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s1.Product = s2.Product
      AND s1.CustomerName <> s2.CustomerName
);


--6. Return how many fruits does each person have in individual fruit level

create table Fruits(Name varchar(50), Fruit varchar(50))
insert into Fruits values ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Orange'),
							('Francesko', 'Banana'), ('Francesko', 'Orange'), ('Li', 'Apple'), 
							('Li', 'Orange'), ('Li', 'Apple'), ('Li', 'Banana'), ('Mario', 'Apple'), ('Mario', 'Apple'), 
							('Mario', 'Apple'), ('Mario',
							'Banana'), ('Mario', 'Banana'), 
							('Mario', 'Orange')

select Name,
[apple],
[orange],
[Banana] from (select name,Fruit from Fruits) as Source
pivot (
count(fruit) for Fruit in ([apple],
[orange],
[Banana])) as p

--7. Return older people in the family with younger ones

create table Family(ParentId int, ChildID int)
insert into Family values (1, 2), (2, 3), (3, 4)

select f.ParentId,f1.ChildID from Family f cross join Family f1
where f.ParentId<f1.ChildID
order by f.ParentId


--8. Write an SQL statement given the following requirements.
--For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas

CREATE TABLE #Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);


INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);

select * from #Orders

select * from #Orders o
where   exists(select 1 from #Orders q
where o.CustomerID=q.CustomerID and q.DeliveryState='ca' and o.DeliveryState='tx')


--9. Insert the names of residents if they are missing


create table #residents(resid int identity, fullname varchar(50), address varchar(100))

insert into #residents values 
('Dragan', 'city=Bratislava country=Slovakia name=Dragan age=45'),
('Diogo', 'city=Lisboa country=Portugal age=26'),
('Celine', 'city=Marseille country=France name=Celine age=21'),
('Theo', 'city=Milan country=Italy age=28'),
('Rajabboy', 'city=Tashkent country=Uzbekistan age=22')

UPDATE r
SET fullname = LTRIM(RTRIM(
        SUBSTRING(r.address,
                  CHARINDEX('name=', r.address) + 5,
                  CHARINDEX(' age=', r.address) - CHARINDEX('name=', r.address) - 5
        )
    ))
FROM #residents r
WHERE (r.fullname IS NULL OR r.fullname = '')
  AND r.address LIKE '%name=%';

select * from #residents


--10. Write a query to return the route to reach from Tashkent to Khorezm. The result should include the cheapest and the most expensive routes


CREATE TABLE #Routes
(
RouteID        INTEGER NOT NULL,
DepartureCity  VARCHAR(30) NOT NULL,
ArrivalCity    VARCHAR(30) NOT NULL,
Cost           MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);

INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Tashkent','Samarkand',100),
(2,'Samarkand','Bukhoro',200),
(3,'Bukhoro','Khorezm',300),
(4,'Samarkand','Khorezm',400),
(5,'Tashkent','Jizzakh',100),
(6,'Jizzakh','Samarkand',50);

;WITH RouteCTE AS
(
    -- Boshlang'ich nuqta
    SELECT 
        DepartureCity,
        ArrivalCity,
        CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(MAX)) AS Route,
        Cost
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'

    UNION ALL

    -- Keyingi shaharlar orqali davom etamiz
    SELECT 
        r.DepartureCity,
        r.ArrivalCity,
        CAST(c.Route + ' - ' + r.ArrivalCity AS VARCHAR(MAX)) AS Route,
        c.Cost + r.Cost
    FROM #Routes r
    INNER JOIN RouteCTE c
        ON c.ArrivalCity = r.DepartureCity
    WHERE c.Route NOT LIKE '%' + r.ArrivalCity + '%'
)

-- Eng arzon
SELECT TOP 1 Route, Cost
FROM RouteCTE
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost ASC

UNION ALL

-- Eng qimmat
SELECT TOP 1 Route, Cost
FROM RouteCTE
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost DESC;


--11. Rank products based on their order of insertion.

CREATE TABLE #RankingPuzzle
(
     ID INT
    ,Vals VARCHAR(10)
)

 
INSERT INTO #RankingPuzzle VALUES
(1,'Product'),
(2,'a'),
(3,'a'),
(4,'a'),
(5,'a'),
(6,'Product'),
(7,'b'),
(8,'b'),
(9,'Product'),
(10,'c')


select *,row_number() over(order by (select null)) as Rank from #RankingPuzzle

--Question 12
--Find employees whose sales were higher than the average sales in their department

CREATE TABLE #EmployeeSales (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    SalesAmount DECIMAL(10,2),
    SalesMonth INT,
    SalesYear INT
);

INSERT INTO #EmployeeSales (EmployeeName, Department, SalesAmount, SalesMonth, SalesYear) VALUES
('Alice', 'Electronics', 5000, 1, 2024),
('Bob', 'Electronics', 7000, 1, 2024),
('Charlie', 'Furniture', 3000, 1, 2024),
('David', 'Furniture', 4500, 1, 2024),
('Eve', 'Clothing', 6000, 1, 2024),
('Frank', 'Electronics', 8000, 2, 2024),
('Grace', 'Furniture', 3200, 2, 2024),
('Hannah', 'Clothing', 7200, 2, 2024),
('Isaac', 'Electronics', 9100, 3, 2024),
('Jack', 'Furniture', 5300, 3, 2024),
('Kevin', 'Clothing', 6800, 3, 2024),
('Laura', 'Electronics', 6500, 4, 2024),
('Mia', 'Furniture', 4000, 4, 2024),
('Nathan', 'Clothing', 7800, 4, 2024);


with cte as(select *,avg(SalesAmount) over (partition by department) as DeptAvgSales from #EmployeeSales)
select EmployeeID,EmployeeName,SalesAmount from cte 
where SalesAmount>DeptAvgSales

--13. Find employees who had the highest sales in any given month using EXISTS


SELECT s.CustomerName, MONTH(s.SaleDate) AS SaleMonth, 
       SUM(s.Quantity * s.Price) AS TotalSale
FROM #Sales s
GROUP BY s.CustomerName, MONTH(s.SaleDate)
HAVING EXISTS (
    SELECT 1
    FROM (
        SELECT MONTH(SaleDate) AS SaleMonth, MAX(SUM_Q) AS MaxSale
        FROM (
            SELECT CustomerName, MONTH(SaleDate) AS SaleMonth, SUM(Quantity*Price) AS SUM_Q
            FROM #Sales
            GROUP BY CustomerName, MONTH(SaleDate)
        ) t
        GROUP BY SaleMonth
    ) m
    WHERE m.SaleMonth = MONTH(s.SaleDate)
      AND m.MaxSale = SUM(s.Quantity * s.Price)
);


--14. Find employees who made sales in every month using NOT EXISTS

SELECT DISTINCT s.CustomerName
FROM #Sales s
WHERE NOT EXISTS (
    SELECT 1
    FROM (
        SELECT DISTINCT MONTH(SaleDate) AS SaleMonth
        FROM #Sales
    ) m
    WHERE NOT EXISTS (
        SELECT 1
        FROM #Sales s2
        WHERE s2.CustomerName = s.CustomerName
          AND MONTH(s2.SaleDate) = m.SaleMonth
    )
);


--15.Retrieve the names of products that are more expensive than the average price of all products.

CREATE TABLE Products (
    ProductID   INT PRIMARY KEY,
    Name        VARCHAR(50),
    Category    VARCHAR(50),
    Price       DECIMAL(10,2),
    Stock       INT
);

INSERT INTO Products (ProductID, Name, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 15),
(2, 'Smartphone', 'Electronics', 800.00, 30),
(3, 'Tablet', 'Electronics', 500.00, 25),
(4, 'Headphones', 'Accessories', 150.00, 50),
(5, 'Keyboard', 'Accessories', 100.00, 40),
(6, 'Monitor', 'Electronics', 300.00, 20),
(7, 'Mouse', 'Accessories', 50.00, 60),
(8, 'Chair', 'Furniture', 200.00, 10),
(9, 'Desk', 'Furniture', 400.00, 5),
(10, 'Printer', 'Office Supplies', 250.00, 12),
(11, 'Scanner', 'Office Supplies', 180.00, 8),
(12, 'Notebook', 'Stationery', 10.00, 100),
(13, 'Pen', 'Stationery', 2.00, 500),
(14, 'Backpack', 'Accessories', 80.00, 30),
(15, 'Lamp', 'Furniture', 60.00, 25);

with cte as(select *,avg(Price) over () as AvgPrice from products)
select  Name from cte 
where Price>AvgPrice

--16. Find the products that have a stock count lower than the highest stock count.

select * from Products
where Stock<>(select max(Stock) from Products)
--17. Get the names of products that belong to the same category as 'Laptop'.

select name from Products
where Category=(select Category from Products
where  Name='Laptop')

--18. Retrieve products whose price is greater than the lowest price in the Electronics category.

select * from Products
where Price>(select min(Price) from Products
where Category='Electronics')


--19. Find the products that have a higher price than the average price of their respective category.

with cte as (select *,avg(Price) over  (partition by category) as CategoryAvg from Products)
select ProductID,Name,Category,Price,Stock from cte 
where  Price>CategoryAvg



CREATE TABLE Orders (
    OrderID    INT PRIMARY KEY,
    ProductID  INT,
    Quantity   INT,
    OrderDate  DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Orders (OrderID, ProductID, Quantity, OrderDate) VALUES
(1, 1, 2, '2024-03-01'),
(2, 3, 5, '2024-03-05'),
(3, 2, 3, '2024-03-07'),
(4, 5, 4, '2024-03-10'),
(5, 8, 1, '2024-03-12'),
(6, 10, 2, '2024-03-15'),
(7, 12, 10, '2024-03-18'),
(8, 7, 6, '2024-03-20'),
(9, 6, 2, '2024-03-22'),
(10, 4, 3, '2024-03-25'),
(11, 9, 2, '2024-03-28'),
(12, 11, 1, '2024-03-30'),
(13, 14, 4, '2024-04-02'),
(14, 15, 5, '2024-04-05'),
(15, 13, 20, '2024-04-08');


--20. Find the products that have been ordered at least once.

select * from Products
where exists (select 1 from Orders where Orders.ProductID=Products.ProductID)

--21. Retrieve the names of products that have been ordered more than the average quantity ordered.

with cte as (select *,avg(quantity) over() avg from Orders)
select cte.OrderID,p.Name,cte.Quantity,cte.OrderDate from cte
join products p on p.productid=cte.productid
where Quantity>avg


--22. Find the products that have never been ordered.

select * from Products
where not exists (select 1 from Orders where Orders.ProductID=Products.ProductID)


--23. Retrieve the product with the highest total quantity ordered.


select top 1 p.Name,sum(Quantity) as TotalQuantity from Orders
join Products p on p.ProductID=orders.ProductID
group by p.Name
order by TotalQuantity desc
