1. BULK INSERT is a T-SQL command used to import large amounts of data from a data file (e.g., .txt, .csv) into a SQL Server table quickly and efficiently.
2. .csv (Comma-Separated Values)
   .txt (Text files)
   .xml (Extensible Markup Language)
   .json (JavaScript Object Notation)
3. create table Products (
    ProductID int primary key,
    ProductName varchar(50),
    Price decimal(10, 2)
);
4. insert into Products (ProductID, ProductName, Price)values
(1, 'Yabloko', 29.99),
(2, 'Mishka', 19.49),
(3, 'Monitor', 199.99);
5. NULL: Indicates no value or missing value.
   NOT NULL: Column must contain a value; cannot be left empty.
6. alter table Products
   add constraint UQ_ProductName unique (ProductName);
7. -- This query selects all products with a price greater than 50
    select * from Products
    where Price > 50;
8. alter table Products
   add CategoryID int;
9. create table Categories (
    CategoryID int primary key,
    CategoryName varchar(50) unique
);
10. The IDENTITY property automatically generates sequential values for a column, often used for primary keys.
11. BULK insert Products
    from 'C:\Data\products_data.txt'
    with(
    firstrow = 2
    fieldterminator = ',',
    rowterminator = '\n',
    );
12. alter table Products
    add constraint FK_Products_Categories
    foreign key(CategoryID) references Categories(CategoryID);
13. Primary key : Ensures each row in a table is uniquely identifiable. It's the main identifier for a record.
    Unique key: Ensures that all values in a column (or combination of columns) are unique, but it's not necessarily the main identifier.
14. alter table Products
    add constraint chk_price_positive check (Price > 0);
15. alter table Products
    add Stock int not null;
16. select ProductID, ProductName, ISNULL(Price, 0) as SafePrice
    from Products;
17. FOREIGN KEY ensures referential integrity by linking a column in one table to the primary key in another table. It prevents invalid data from being inserted.

18. create table Customers (
    CustomerID int primary key,
    Name varchar(50),
    Age int check (Age >= 18)
);

19. create table Invoice (
    InvoiceID int primary key identity(100, 10) ,
    InvoiceDate date
);

20. create table OrderDetails (
    OrderID int,
    ProductID int,
    Quantity int,
    primary key (OrderID, ProductID)
);
21. ISNULL(expr1, replacement) — returns replacement if expr1 is NULL.

    COALESCE(expr1, expr2, ..., exprN) — returns first non-NULL value in list.

    COALESCE is more flexible with multiple values and supports different data types.
  22. create table Employees (
    EmpID int primary key,
    Name varchar(50),
    Email varchar(100) unique
);

23. alter table Products
    add constraint FK_Products_Categories_Cascade
    foreign key (CategoryID) references Categories(CategoryID)
    on delete cascade
    on update cascade;









