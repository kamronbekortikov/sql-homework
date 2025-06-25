1. Data: Data refers to raw facts and figures without context. For example, "John", "25", or "A+" are pieces of data.
  Database: A database is an organized collection of data, typically stored and accessed electronically from a computer system.
  Relational Database: A relational database stores data in tables (relations) with rows and columns, where each table has a unique key. It supports relationships between tables using keys.
  Table: A table is a collection of related data entries consisting of columns and rows. Each column represents a field, and each row represents a record.
2. 1) High Performance and Scalability
  Optimized for fast data retrieval and able to handle large-scale databases.
  2) Security Features
  Provides authentication, encryption, and roles/permissions for secure data access.
  3) Backup and Restore
    Supports comprehensive backup options for disaster recovery.
  4) SQL Server Management Studio (SSMS)
    A GUI tool for managing SQL Server instances and databases.
  5) Support for Stored Procedures and Triggers
  Allows complex business logic to be embedded in the database.
3. 1) Windows Authentication
  Uses Windows credentials of the user.
  2) SQL Server Authentication
  Requires a separate login ID and password configured within SQL Server.
4. CREATE DATABASE SchoolDB
   go
5. CREATE table Students (
    StudentID int PRIMARY KEY,
    Name varchar(50),
    Age int
    )
6. | Feature   | SQL Server                             | SSMS (SQL Server Management Studio) | SQL (Structured Query Language)    |
   | --------- | -------------------------------------- | ----------------------------------- | ---------------------------------- |
   | Type      | Database Management System (DBMS)      | GUI Management Tool                 | Query Language                     |
   | Use       | Hosts, stores, and processes databases | Used to manage SQL Server visually  | Used to query and manage databases |
   | Interface | Background Service                     | Graphical Interface                 | Text-based Command Language        |
7. 
8. Insert into Students (StudentID, Name, Age) values
  (1, 'Anvar',   21, 
   2, 'Bobur'  ,   22, 
   3, 'Abror', 20)

