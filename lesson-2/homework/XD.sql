--1.Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2)).

create table Employees (EmpID int,Name varchar(50),Salary decimal(10,2))

--2.Insert three records into the Employees table using different
--INSERT INTO approaches (single-row insert and multiple-row insert).

insert into Employees values (1000,'Jasur',3000000)

insert into Employees values (1001,'Ulug`bek',4000000)

insert into Employees values (1002,'Asad',5000000)

--3.Update the Salary of an employee to 7000 where EmpID = 1.

update Employees set Salary=7000 where EmpID=1

--4.Delete a record from the Employees table where EmpID = 2.

delete from Employees where EmpID=2

--5.Give a brief definition for difference between DELETE, TRUNCATE, and DROP.

--DROP command removes a table from the database, DELETE removes records from a table,
--and TRUNCATE removes all rows from a table

--6.Modify the Name column in the Employees table to VARCHAR(100).

Alter table Employees
ALTER column name varchar(100)

--7.Add a new column Department (VARCHAR(50)) to the Employees table.

Alter table Employees
Add Department varchar(50)

--8.Change the data type of the Salary column to FLOAT.

Alter table Employees
ALTER column Salary float

--9.Create another table Departments with columns DepartmentID (INT, PRIMARY KEY)
--and DepartmentName (VARCHAR(50)).

create table Departments (DepartmentID int,DepartmentName varchar(50))

--10.Remove all records from the Employees table without deleting its structure.

truncate table Employeess

--11.Insert five records into the Departments table using
--INSERT INTO SELECT method(you can write anything you want as data).

insert into Departments (DepartmentID,DepartmentName)
select EmpID,name from Employees

--12.Update the Department of all employees where Salary > 5000 to 'Management'.

update Employees set Department='Managment' where Salary>5000

--13.Write a query that removes all employees but keeps the table structure intact.

truncate table Employeess

--14.Drop the Department column from the Employees table.

alter table employees
drop column department

--15.Rename the Employees table to StaffMembers using SQL commands.

sp_rename 'employees','StaffMember' 

--16.Write a query to completely remove the Departments table from the database.

drop table Departments

--17.Create a table named Products with at least 5 columns, including:
--ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)

create table Products (ProductID int,ProductName varchar(50),Category varchar(50),Price decimal(10,2))

--18.Add a CHECK constraint to ensure Price is always greater than 0.

alter table products
add CONSTRAINT chk_Price
check (price>0)

--19.Modify the table to add a StockQuantity column with a DEFAULT value of 50.

alter table Products add StockQuantity varchar (50) default 'pending'

--20.Rename Category to ProductCategory

sp_rename 'Products.Category',  'ProductCategory', 'COLUMN'

--21.Insert 5 records into the Products table using standard INSERT INTO queries.

insert into Products values (1000,'Olma','Meva',15000,'100kg')

insert into Products values (1001,'Banan','Meva',25000,'200kg')

insert into Products values (1002,'Sok','Ichimlik',18000,'500 dona')

insert into Products values (1003,'Grand','Muzqaymoq',10000,'50 dona')

insert into Products values (1004,'Alpengold','shokolad',20000,'232 dona')

--22.Use SELECT INTO to create a backup table called Products_Backup containing all Products data.

select* into Products_Backup from Products

--23.Rename the Products table to 'Inventory'.

sp_rename 'Products', 'Inventory'

--24.Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.

alter table inventory
alter column Price float

--25.Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5 to Inventory table.

alter table Inventory add ProductCode int identity (1000, 5)
