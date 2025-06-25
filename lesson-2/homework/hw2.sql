
-- 1. Create Employees table
CREATE TABLE Employees (
    emp_id int,
    name varchar(50),
    salary decimal(10,2)
);

-- 2. Insert single row
insert into Employees (emp_id, name, salary) values(1, 'Anvar', 8000.00)

-- Insert multiple rows
insert into Employees (emp_id, name, salary) values (2, 'Bobur', 9500.00), (3, 'Abror', 5000.00), (4, 'Nozima', 4500.00) 

-- 3. Update Salary
update Employees
set Salary = 7000.00
where emp_id = 1;

-- 4. Delete a record
delete from Employees
where emp_id = 2;

-- 5. Difference between DELETE, TRUNCATE, and DROP
-- DELETE: Removes rows based on condition, can be rolled back if in a transaction.
-- TRUNCATE: Removes all rows quickly, can't be rolled back (usually), keeps table structure.
-- DROP: Deletes the entire table and its structure from the database.

-- 6. Modify Name column
alter table Employees
alter column name varchar(100);

-- 7. Add new column
alter table Employees
add Department varchar(50);

-- 8. Change Salary data type
alter table Employees
alter column Salary float;

-- 9. Create Departments table
create table Departments (
    Department_id int primary key,
    Department_name varchar(50)
);

-- 10. Remove all records from Employees table
truncate table Employees;

select * from Employees

-- 11. Insert 5 records using INSERT INTO SELECT (mocking data)

insert into Departments (Department_id, Department_name)
select 1, 'HR' 
select 2, 'Finance'
select 3, 'IT' 
select 4, 'Marketing' 
select 5, 'Director';


select * from[dbo].[Departments]

-- 12. Update Department where Salary > 5000
update Employees
set Department = 'Management'
where salary > 5000;


-- 13. Remove all employees but keep structure
delete from Employees;
truncate table Employes; 

-- 14. Drop Department column
alter table Employees
drop column Department;


-- 15. Rename Employees to StaffMembers
exec sp_rename 'Employees', 'StaffMembers';

select * from StaffMembers

-- 16. Remove Departments table completely
drop table Departments;

-- 17. Create Products table
create table Products (
    ProductID int primary key, 
    ProductName varchar(100),
    Category varchar(50),
    Price decimal(10,2),
    Description varchar(255)
);

-- 18. Add CHECK constraint

alter table Products
add constraint chk_Price check (Price > 0);

-- 19. Add StockQuantity with default
alter table Products
add StockQuantity int default 50;


-- 20. Rename Category to ProductCategory
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

-- 21. Insert 5 records
insert into Products (ProductID, ProductName, ProductCategory, Price, Description) values
(1, 'Noutbook', 'Elektronikalar', 1200.00, 'Oyin uchun'),
(2, 'Stul', 'Mebel', 150.00, 'Ofis stuli'),
(3, 'Smartfone', 'Elektronikalar', 800.00, 'Suvga chidamli'),
(4, 'Doska', 'Mebel', 250.00, 'oquv doskasi'),
(5, 'Monitor', 'Elektronikalar', 300.00, '4K monitor');

-- 22. Create Products_Backup using SELECT INTO
select * into Products_Backup from Products;

select * from Products

-- 23. Rename Products to Inventory
EXEC sp_rename 'Products', 'Inventory';


-- 24. Alter Price to FLOAT
alter table Inventory
alter column Price float;

select * from inventory
