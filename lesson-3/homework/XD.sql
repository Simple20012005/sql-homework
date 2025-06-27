--1.Define and explain the purpose of BULK INSERT in SQL Server.

--BULK INSERT loads data from a data file into a table. 
--This functionality is similar to that provided by the in option of the bcp command.

--2.List four file formats that can be imported into SQL Server.

--Excel, CSV, XML, JSON, Text, MS Access

--3.Create a table Products with columns: 
--ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).

Create  table Products( ProductID INT PRIMARY KEY, ProductName VARCHAR(50), Price DECIMAL(10,2))

--4.Insert three records into the Products table using INSERT INTO.

insert into Products values(1,'Apple',20)

insert into Products values(2,'Banana',15)

insert into Products values(3,'Cherry',30)

--5.Explain the difference between NULL and NOT NULL.

--NOT NULL means a column to NOT accept NULL values. Null in other way means zero or empty value.
--Thus, Null means you can leave that field empty. 
--And Not Null means you can't leave the value of that field empty

--6.Add a UNIQUE constraint to the ProductName column in the Products table.

alter table Products
add constraint uk_Productname unique (ProductName)

--7.Write a comment in a SQL query explaining its purpose.

--Bu mahsulotlar qayta takrorlanishini oldini olish uchun.

--8.Add CategoryID column to the Products table.

alter table Products
add CategoryID int

--9.Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.

Create  table Categories( CategoryID INT PRIMARY KEY, CategoryName VARCHAR(50) unique)

--10.Explain the purpose of the IDENTITY column in SQL Server.

--Identity columns can be used for generating key values. 
--The identity property on a column guarantees the following conditions:
--Each new value is generated based on the current seed and increment. 
--Each new value for a particular transaction is different from other concurrent transactions on the table.

--11.Use BULK INSERT to import data from a text file into the Products table.
bulk insert [F_33_lesson3].[dbo].[Products]
from 'C:\Users\islom\Desktop\MAAB Classes\Source\Products.csv'
with (
firstrow=2,
fieldterminator=',',
rowterminator='\n'
)

--12.Create a FOREIGN KEY in the Products table that references the Categories table.

alter table Products
add constraint fg_d foreign key (CategoryID) references Categories(CategoryID)

--13.Explain the differences between PRIMARY KEY and UNIQUE KEY.

--A Primary Key cannot contain null values and only one Primary Key is allowed per table. 
--In contrast, a Unique Key can contain null values (though usually only one per column) 
--and a table can have multiple Unique Keys


--14.Add a CHECK constraint to the Products table ensuring Price > 0.

Alter table Products
add constraint chk_Price
check (price>0)

--15.Modify the Products table to add a column Stock (INT, NOT NULL).

Alter table Products
add Stock INT not null

--16.Use the ISNULL function to replace NULL values in Price column with a 0.

UPDATE Products
SET Price = 0
WHERE Price IS NULL;

--17.Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.

--A foreign key (FK) is a column or combination of columns that is used to establish and 
--enforce a link between the data in two tables to control 
--the data that can be stored in the foreign key table.

--18.Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.

Create  table Customers( CustomerID INT , CustomerName VARCHAR(50), Age int check(age>=18))

--19.Create a table with an IDENTITY column starting at 100 and incrementing by 10.

create table Students (Id int identity(100,10), Name varchar(30))

--20.Write a query to create a composite PRIMARY KEY in a new table c.
CREATE TABLE OrderDetails (
  Custumer_ID INT NOT NULL,
  Product_id INT NOT NULL,
  name VARCHAR(255),
  PRIMARY KEY (Custumer_ID, Product_id)
)
--21.Explain the use of COALESCE and ISNULL functions for handling NULL values.

--In SQL, COALESCE and ISNULL are functions used to handle NULL values,
--providing a default value when a column or expression evaluates to NULL.

--22.Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.

Create  table Employees( EmpID INT PRIMARY KEY, Email varchar(50) unique)

--23.Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.

CREATE TABLE Countries
 
(CountryID INT PRIMARY KEY,
CountryName VARCHAR(50),
CountryCode VARCHAR(3))
 
 
CREATE TABLE States
 
(StateID INT PRIMARY KEY,
StateName VARCHAR(50),
StateCode VARCHAR(3),
CountryID INT)
 
 
 
ALTER TABLE [dbo].[States]  WITH CHECK ADD  CONSTRAINT [FK_States_Countries] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Countries] ([CountryID])
ON DELETE CASCADE
GO
 
ALTER TABLE [dbo].[States] CHECK CONSTRAINT [FK_States_Countries]
GO
