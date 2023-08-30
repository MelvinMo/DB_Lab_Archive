# DB_Lab_Archive
This repository houses the course materials for my undergraduate database design lab, encompassing assignments and a final project on designing an automotive sales database.
## Assignments
### Lab 1
This lab focuses on database schema design by defining tables, columns, keys, and relationships, as well as inserting sample data using INSERT statements and basic SELECT queries to retrieve data.

### Lab 2
This lab covers more advanced SELECT statements, including multi-table joins, aggregate functions like COUNT and MAX, nested subqueries, and UPDATE statements to modify data.

### Lab 3
This lab demonstrates SQL Server administration concepts like creating logins, users, server roles, and assigning permissions, as well as using SELECT INTO to copy data into a new table.

### Lab 4
This lab practices GROUP BY queries with ROLLUP to generate grouped summary reports, JOINs across multiple related tables, and subqueries to count records matching a condition.

### Lab 5
This lab explores data pivoting by rotating rows into columns for reporting using PIVOT, string manipulation functions like LEN, LEFT, RIGHT, and SUBSTRING, and user-defined functions including a scalar UDF to convert dates and a table-valued UDF to return result sets.

### Lab 6
This lab focuses on DML triggers, inserts sample data to fire the triggers, and logs changes to a separate audit table. It also uses SELECT INTO to copy data to a new table and a stored procedure to compare and find differences between the tables.

### Lab 7
This lab covers the bcp utility for bulk import and export of data between SQL Server and text files. It exports a table to text, imports it into a new table, exports a query result to text, and exports a table to a .dat file.

### Lab 8
This lab demonstrates transaction isolation levels and concurrency issues like dirty reads and non-repeatable reads using BEGIN TRAN, COMMIT, and SET TRANSACTION ISOLATION LEVEL statements.

## Project
"Carstock" is an automotive sales database, a robust and comprehensive system specifically designed for a global auto sales company. Its primary objective is to facilitate the seamless buying and selling of vehicles by providing a centralized platform for both customers and suppliers. The database schema, implemented using Microsoft SQL Server, includes well-defined tables to store crucial data related to vehicles, customers, suppliers, sales transactions, and other relevant entities.

To ensure the integrity and efficiency of the database, relationships between tables were established using primary keys and foreign keys. This allowed for proper data organization and efficient retrieval of interconnected information. Additionally, a substantial amount of sample data, comprising over 200,000 records, was generated and populated across the various entities.

In order to encapsulate business logic and gain valuable insights from the data, several database objects were implemented. These included the creation of views, which allowed for the retrieval of consolidated vehicle and customer details, as well as functions that enabled the filtering of cars based on color, mileage, and other specifications. Triggers were also utilized to enforce data integrity rules, ensuring that the database maintained consistent and reliable information.

To showcase the practical usage of the database, a user-friendly graphical user interface (GUI) was developed using C# with ADO.NET. This GUI provided a seamless and intuitive way for users to interact with the database objects. Users could easily browse the full inventory, check for available cars, explore offers, make purchases, and list vehicles for sale. The GUI effectively demonstrated the practical application of the database system in real-world scenarios.
