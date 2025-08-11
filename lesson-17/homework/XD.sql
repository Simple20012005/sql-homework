create database F33_homework17

use F33_homework17

--2.

CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);


select e.name from employee e
join (select e1.id from Employee e1
join Employee  e2 on e1.id=e2.managerId
group by e1.id
having count(e2.id)>=5 ) sub ON sub.id = e.id

SELECT e.name
FROM Employee e
JOIN (
    SELECT managerId
    FROM Employee
    WHERE managerId IS NOT NULL
    GROUP BY managerId
    HAVING COUNT(*) >= 5
) m ON e.id = m.managerId;


--3.

CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

select * from Products
select * from Orders

select p.product_name,sub.unit from Products p
join(select product_id,sum(unit) unit from Orders
where YEAR(order_date)=2020 and MONTH(order_date)=2
group by product_id
having sum(unit)>=100) sub on sub.product_id=p.product_id

--4.

DROP TABLE  Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');

select * from Orders

select CustomerID,vendor,count(Vendor) vendorcount from Orders
group by CustomerID,Vendor

--5.

DECLARE @Check_Prime INT = 41;

WITH Numbers AS (
    SELECT 2 AS n
    UNION ALL
    SELECT n + 1 FROM Numbers WHERE n <= sqrt(@Check_Prime)-1 
)
select case
when exists( SELECT * FROM Numbers 
WHERE @Check_Prime % n=0) then 'Not prime'
else 'Prime' end as Result
OPTION (MAXRECURSION 0);


--6............


CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');

select sub1.Device_id,sub1.max_signal_location,s.Locations as max_signal_location,sub1.no_of_location from (select Device_id,count(distinct Locations) as no_of_location,count( Locations) max_signal_location from Device
group by Device_id) sub1
join
(select Device_id,Locations from (select Device_id,Locations,count( Locations) max_signal_location,
rank() over(partition by device_id order by  count( Locations)desc) as Rank from Device
group by Device_id,Locations) sub
where rank=1) s on sub1.Device_id=s.Device_id;



select 
	Device_id, 
	count(distinct Locations) as no_of_location,
	count( Locations) max_signal_location,
	(select top 1 Locations from Device sq where sq.Device_id=q.Device_id group by device_id, Locations order by count(*) desc) max_signal_location
from Device q
group by Device_id;


--7......................

drop table Employee

CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);

select e1.* from Employee e1
join(select DeptID,avg(Salary) AvgSalary from Employee
group by DeptID ) e2 on e1.DeptID=e2.DeptID
where e1.Salary>e2.AvgSalary


--8...........................

-- Step 1: Create the table
CREATE TABLE Numbers (
    Number INT
);

-- Step 2: Insert values into the table
INSERT INTO Numbers (Number)
VALUES
(25),
(45),
(78);


-- Step 1: Create the Tickets table
CREATE TABLE Tickets (
    TicketID VARCHAR(10),
    Number INT
);

-- Step 2: Insert the data into the table
INSERT INTO Tickets (TicketID, Number)
VALUES
('A23423', 25),
('A23423', 45),
('A23423', 78),
('B35643', 25),
('B35643', 45),
('B35643', 98),
('C98787', 67),
('C98787', 86),
('C98787', 91);


select sum(sub.lotery) as lotery from (select t.TicketID,count(t.Number) as count,
case when count(t.Number)=3 then 100 
else 10
end as Lotery
from Tickets t
 join Numbers n on t.Number=n.Number
 group by  t.TicketID) sub

 --9...................

 CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);

select * from Spending

select User_id,Spend_date,Platform,count(*) from Spending
group by Spend_date,User_id,Platform



--10...........................


DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);


WITH CTE AS (
    SELECT g.Product, 1 AS Quantity, 1 AS cnt
    FROM Grouped g
    UNION ALL
    SELECT c.Product, 1, c.cnt + 1
    FROM CTE c
    JOIN Grouped g ON c.Product = g.Product
    WHERE c.cnt < g.Quantity
)
SELECT c.Product, c.Quantity
FROM CTE c
ORDER BY c.Product
OPTION (MAXRECURSION 0);
