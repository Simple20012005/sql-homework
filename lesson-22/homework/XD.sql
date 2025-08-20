create database F33_homework22

use F33_homework22

CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
    (1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
    (2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
    (3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
    (4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
    (5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
    (6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
    (7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
    (8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
    (9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
    (10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
    (11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
    (12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
    (13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
    (14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
    (15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
    (16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
    (17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
    (18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
    (19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
    (20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
    (21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
    (22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
    (23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
    (24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
    (25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East')


--1.Compute Running Total Sales per Customer

select customer_name,quantity_sold,order_date,sum(quantity_sold) over(partition by customer_id order by order_date) as RunningTotal from sales_data;

--2.Count the Number of Orders per Product Category

SELECT product_category, COUNT(*) AS order_count
FROM sales_data
GROUP BY product_category;


--3.Find the Maximum Total Amount per Product Category

select product_category,max(total_amount) as MaxAmount  from sales_data
group by product_category

--4.Find the Minimum Price of Products per Product Category

select product_category,min(unit_price) as MinPrice from sales_data
group by product_category

--5.Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)

select*,
avg(quantity_sold) over (order by order_date rows between 1 preceding and 1 following ) as MovingAvg
from sales_data

--6.Find the Total Sales per Region

select region,sum(total_amount) TotalSales from sales_data
group by region;

--7.Compute the Rank of Customers Based on Their Total Purchase Amount

with cte as (select customer_name,sum(total_amount) as TotalAmount from sales_data group by customer_name
)
select *,rank() over(order by totalAmount desc) as Rank from cte;

--8.Calculate the Difference Between Current and Previous Sale Amount per Customer

with cte as (select *,lag(total_amount) over (partition by customer_id order by order_date) as Difference from sales_data)
select customer_id,customer_name,total_amount,order_date,isnull(total_amount - Difference,0) as Difference from cte;

--9.Find the Top 3 Most Expensive Products in Each Category

with cte as (select *,ROW_NUMBER() over (partition by product_category order by unit_price desc) as Top3Products from sales_data )
select * from cte
where Top3Products<=3;

--10.Compute the Cumulative Sum of Sales Per Region by Order Date

select *,sum(total_amount) over(partition by region order by order_date) as CumulativeSum from sales_data

--11.Compute Cumulative Revenue per Product Category

select *,sum(total_amount) over (partition by product_category order by order_date ) as CumulativeRevenue from sales_data

--12.Here you need to find out the sum of previous values. Please go through the sample input and expected output.

-- Jadval yaratish
create table MyTable (
    ID int
);

-- Ma'lumot kiritish
insert into MyTable (ID) values
(1),
(2),
(3),
(4),
(5);

select *,sum(id) over(order by id) SumPreValues from MyTable


--13.Sum of Previous Values to Current Value

CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

select *,sum(Value) OVER (ORDER BY Value rows between 1 preceding and current row) 'Sum of Previous' from OneColumn;


--14.Find customers who have purchased items from more than one product_category

with cte as (select customer_id,customer_name,product_category,count(*) as Count from sales_data
group by customer_id,customer_name,product_category)
select customer_id,customer_name from cte
group by customer_id,customer_name
having count(*)>1;

--15.Find Customers with Above-Average Spending in Their Region


with cte as (select *,
sum(total_amount) over(partition by customer_id) as Total,
avg(total_amount) over (partition by region) as Avg 
from sales_data)
select distinct customer_id,customer_name from cte
where Total>Avg


--16.Rank customers based on their total spending (total_amount) within each region. 
--If multiple customers have the same spending, they should receive the same rank.

with cte as (select customer_id,customer_name,region,sum(total_amount) as TotalAmount from sales_data
group by customer_id,customer_name,region)
select *,DENSE_RANK() over(partition by region order by totalamount desc) as Rank from cte

--17.Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.

select *,sum(total_amount) over (partition by customer_id order by order_date) as cumulative_sales from sales_data

select * from sales_data;

--18.Calculate the sales growth rate (growth_rate) for each month compared to the previous month.

with cte as(select year(order_date) as Year,month(order_date) as Month,sum(total_amount) as Total_Sales from sales_data
group by year(order_date),month(order_date)
),
cte1 as (select *,lag(Total_Sales) over ( order by year,month) as PreviousTotal from cte)
select  *,Total_Sales/PreviousTotal*100-100 as growth_rate from cte1 ;

--19.Identify customers whose total_amount is higher than their last order''s total_amount.(Table sales_data)

with last_order as (
    select customer_name, total_amount as last_total_amount
    from (
        select customer_name, total_amount,
               row_number() over (partition by customer_name order by order_date desc) as rn
        from sales_data
    ) t
    where rn = 1
)
select s.customer_id, s.customer_name, s.order_date, s.total_amount, l.last_total_amount
from sales_data s
join last_order l 
    on s.customer_name = l.customer_name
where s.total_amount > l.last_total_amount
  and s.order_date < (
        select max(order_date) from sales_data s2 where s2.customer_name = s.customer_name
      );


--20.Identify Products that prices are above the average product price

select * from sales_data;

select distinct product_name,unit_price from sales_data
where unit_price>(select avg(unit_price) from sales_data)

--21.In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column. 
--The challenge here is to do this in a single select. For more details please see the sample input and expected output.

with cte as (select *,sum(Val1+Val2) over(partition by grp) as Tot,ROW_NUMBER() over(partition by grp order by id) as Rownum from MyData),
cte1 as (select * from cte 
where Rownum=1)
select id,Grp,val1,Val2,null as Tot from cte
where Rownum<>1
union all
select id,Grp,val1,Val2,Tot from cte1
order by id

--22.Here you have to sum up the value of the cost column based on the values of Id. 
--For Quantity if values are different then we have to add those values.
--Please go through the sample input and expected output for details.

CREATE TABLE TheSumPuzzle (
    ID INT, Cost INT, Quantity INT
);
INSERT INTO TheSumPuzzle VALUES
(1234,12,164), (1234,13,164), (1235,100,130), (1235,100,135), (1236,12,136);

with cte as (select id,sum(cost) as cost ,Quantity  from TheSumPuzzle
group by id,Quantity)
select id,sum(cost) as cost,sum(Quantity) as Quantity from cte
group by id



--23.From following set of integers, write an SQL statement to determine the expected outputs.

CREATE TABLE Seats 
( 
SeatNumber INTEGER 
); 

INSERT INTO Seats VALUES 
(7),(13),(14),(15),(27),(28),(29),(30), 
(31),(32),(33),(34),(35),(52),(53),(54); 


;with cte as (
    select SeatNumber,
           lag(SeatNumber) over (order by SeatNumber) as prev_seat
    from Seats
)
select prev_seat + 1 as GapStart, SeatNumber - 1 as GapEnd
from cte
where prev_seat is not null
  and SeatNumber - prev_seat > 1

union all
select 1, (select min(SeatNumber) from Seats) - 1

union all
select (select max(SeatNumber) from Seats) + 1, 100
order by GapStart
