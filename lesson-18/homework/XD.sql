create database F33_homework18

use F33_homework18

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES
(1, 'Samsung Galaxy S23', 'Electronics', 899.99),
(2, 'Apple iPhone 14', 'Electronics', 999.99),
(3, 'Sony WH-1000XM5 Headphones', 'Electronics', 349.99),
(4, 'Dell XPS 13 Laptop', 'Electronics', 1249.99),
(5, 'Organic Eggs (12 pack)', 'Groceries', 3.49),
(6, 'Whole Milk (1 gallon)', 'Groceries', 2.99),
(7, 'Alpen Cereal (500g)', 'Groceries', 4.75),
(8, 'Extra Virgin Olive Oil (1L)', 'Groceries', 8.99),
(9, 'Mens Cotton T-Shirt', 'Clothing', 12.99),
(10, 'Womens Jeans - Blue', 'Clothing', 39.99),
(11, 'Unisex Hoodie - Grey', 'Clothing', 29.99),
(12, 'Running Shoes - Black', 'Clothing', 59.95),
(13, 'Ceramic Dinner Plate Set (6 pcs)', 'Home & Kitchen', 24.99),
(14, 'Electric Kettle - 1.7L', 'Home & Kitchen', 34.90),
(15, 'Non-stick Frying Pan - 28cm', 'Home & Kitchen', 18.50),
(16, 'Atomic Habits - James Clear', 'Books', 15.20),
(17, 'Deep Work - Cal Newport', 'Books', 14.35),
(18, 'Rich Dad Poor Dad - Robert Kiyosaki', 'Books', 11.99),
(19, 'LEGO City Police Set', 'Toys', 49.99),
(20, 'Rubiks Cube 3x3', 'Toys', 7.99);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate)
VALUES
(1, 1, 2, '2025-04-01'),
(2, 1, 1, '2025-04-05'),
(3, 2, 1, '2025-04-10'),
(4, 2, 2, '2025-04-15'),
(5, 3, 3, '2025-04-18'),
(6, 3, 1, '2025-04-20'),
(7, 4, 2, '2025-04-21'),
(8, 5, 10, '2025-04-22'),
(9, 6, 5, '2025-04-01'),
(10, 6, 3, '2025-04-11'),
(11, 10, 2, '2025-04-08'),
(12, 12, 1, '2025-04-12'),
(13, 12, 3, '2025-04-14'),
(14, 19, 2, '2025-04-05'),
(15, 20, 4, '2025-04-19'),
(16, 1, 1, '2025-03-15'),
(17, 2, 1, '2025-03-10'),
(18, 5, 5, '2025-02-20'),
(19, 6, 6, '2025-01-18'),
(20, 10, 1, '2024-12-25'),
(21, 1, 1, '2024-04-20');

--1....................

create table #MonthlySales(
ProductID int,
TotalRevenue DECIMAL(10,2),
TotalQuantity int);

insert into #MonthlySales
select s.ProductID,sum(p.Price*s.Quantity) TotalRevenue,sum(s.Quantity) TotalQuantity  from Sales s
join Products p on s.ProductID=p.ProductID
where s.SaleDate between '2025-08-01' and '2025-08-31'
group by s.ProductID

--2.......................


create view vw_ProductSalesSummary as
select p.ProductID,p.ProductName,p.Category,sum(s.Quantity) TotalQuantitySold  from Sales s
join Products p on s.ProductID=p.ProductID
group by p.ProductID,p.ProductName,p.Category

--3.......................


create function fn_GetTotalRevenueForProduct(
@Productid int)
returns table 
as
return
(select s.ProductID,p.Price*sum(s.Quantity) TotalRevenue  from Sales s
join Products p on s.ProductID=p.ProductID
where s.ProductID=@Productid
group by s.ProductID,p.Price)

--4........................

create function fn_GetSalesByCategory(@Category VARCHAR(50))
returns table
as
return
select p.ProductName,sum(p.Price*s.Quantity) TotalRevenue,sum(s.Quantity) TotalQuantity  from Sales s
join Products p on s.ProductID=p.ProductID
where p.Category=@Category
group by p.ProductName

--5................................

Create function dbo.fn_IsPrime (@Number INT)
returns table as
return
(WITH Numbers AS (
    SELECT 2 AS n
    UNION ALL
    SELECT n + 1 FROM Numbers WHERE n <= sqrt(@Number)-1 
)
select case
when exists( SELECT * FROM Numbers 
WHERE @Number % n=0) then 'Not prime'
else 'Prime' end as Result)


--6..................................

create function fn_GetNumbersBetween (@start int,@end int)
returns @Result TABLE (n INT)
as
begin
with cte as
(select @Start as n 
union all
select n+1 from cte
where n<@End)
 INSERT INTO @Result
    SELECT n
    FROM cte
OPTION (MAXRECURSION 0)
return
end


--7..............................

create function getNthHighestSalary (@num int)
returns table
as 
return
(with cte as (select id,salary,DENSE_RANK() over (order  by salary desc ) as rank from Employees)
select salary   HighestNSalary from cte
where rank=@num
union all
select null
where not exists (select 1 from cte where rank=@num))

--8..........................

select top 1 requester_id as id, count(requester_id) as num from 
(select requester_id  from RequestAccepted
union all
select  accepter_id from RequestAccepted) sub
group by requester_id
order by num desc

--9.............................

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    order_date DATE,
    amount DECIMAL(10,2)
);

-- Customers
INSERT INTO Customers (customer_id, name, city)
VALUES
(1, 'Alice Smith', 'New York'),
(2, 'Bob Jones', 'Chicago'),
(3, 'Carol White', 'Los Angeles');

-- Orders
INSERT INTO Orders (order_id, customer_id, order_date, amount)
VALUES
(101, 1, '2024-12-10', 120.00),
(102, 1, '2024-12-20', 200.00),
(103, 1, '2024-12-30', 220.00),
(104, 2, '2025-01-12', 120.00),
(105, 2, '2025-01-20', 180.00);


select c.customer_id,c.name,count(*) total_orders,sum(o.amount) total_amount,max(o.order_date) last_order_date from Customers c
join Orders o on o.customer_id=c.customer_id
group by c.customer_id,c.name


--10.............................


DROP TABLE IF EXISTS Gaps;

CREATE TABLE Gaps
(
RowNumber   INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NULL
);

INSERT INTO Gaps (RowNumber, TestCase) VALUES
(1,'Alpha'),(2,NULL),(3,NULL),(4,NULL),
(5,'Bravo'),(6,NULL),(7,NULL),(8,NULL),(9,NULL),(10,'Charlie'), (11, NULL), (12, NULL)

SELECT 
    RowNumber,
    MAX(CASE WHEN TestCase <> '' THEN TestCase END) 
        OVER (ORDER BY RowNumber ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Workflow
FROM Gaps
ORDER BY RowNumber;
