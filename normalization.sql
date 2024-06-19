-- ANOMLIES
 -- Anomalies are undesirable conditions in a relational database that can lead to data inconsistency, which can lead to data manipulation.
 -- Insertion Anomalies: Occur when you cannot insert valid data due to the structure of the table.
-- Deletion Anomalies: Occur when deleting a row also deletes unrelated data.
-- Update Anomalies: Occur when updating a value in one row requires changes in other rows to maintain consistency, potentially leading to errors.
 
-- Update anomaly
-- Imagine a situation where the price of the "HP Laptop" (ProductID: 1) needs to be updated from ₹50,000 to ₹52,000. Here's the potential update anomaly:

UPDATE stocks
SET price = 160
WHERE stock_id = 1;

-- The problem is that existing trades for "AAPL" at the old price ($150) won't be updated automatically, leading to inconsistent data.

-- DELETE ANOMALY
-- Imagine a situation where a specific stock "TSLA" becomes discontinued and needs to be removed from the database. Here's how a delete anomaly could occur:

-- delete "TSLA" stock from record:

DELETE FROM stocks
WHERE stock_id = 4;


-- INSERTION ANOMALY

INSERT INTO trades (trade_id, stock_id, client_id, broker_id, trade_date, quantity, total_amount)
VALUES (1005, 2, 5, 2, '2024-06-15', 10, 28000);

-- The insertion fails because ClientID (5) doesn't exist in the clients table.


-- Candidate Keys
-- Candidate keys are attributes or combinations of attributes within a relation (table) that uniquely identify each tuple (row).
-- They are essential for maintaining data integrity and enforcing constraints within a database schema

-- Example:
-- stock_id uniquely identifies a stock. broker_id uniquely identifies a broker. client_id uniquely identifies a client. trade_id uniquely identifies a trade.
/*
PRIMARY KEY
-> It is a column or a set of columns that uniquely identifies each record in a table.
-> Eg: Registration number, Driver's license number, Aadhar number etc

Rules for defining the Primary Key
-> Uniqueness: Each value in a primary key must be unique
-> Null values: A primary key cannot contain null values
-> Number of primary keys: A table can only have one primary key
*/

-- Creation of a Primary Key
/*
Syntax for creating a Primary Key:

CREATE TABLE TABLE_NAME(
	COLUMN_NAME DATA_TYPE PRIMARY KEY,
    COLUMN_NAME DATA_TYPE NOT NULL);

*/
create table products
(
	pid int(3) primary key,
    pname varchar(50) not null,
    price int(10) not null,
    stock int(5),
    location varchar(30) check(location in ('Mumbai','Delhi'))
);

-- Adding Primary Key to an already existing table
/*
Syntax:
ALTER TABLE TABLE_NAME
ADD PRIMARY KEY (COLUMN_NAME);
*/
Alter table products
add primary key (pid);

-- Deleting Primary Key from a table
/*
Syntax:
ALTER TABLE TABLE_NAME
DROP PRIMARY KEY;
*/
Alter table products
drop primary key;

/*
FOREIGN KEY
-> It is a column or group of columns in a database that connects the data in one table to the data in another table.
-> It acts as a cross-reference between tables by referencing the primary key of another table, thereby establishing a link between them.

Need of Foreign Key in dbms:
-> Data Integrity: We need foreign keys as they help us making sure that data is consistent, complete, between both the tables and overall accuracy is maintained.
-> Establishing Relationships: The main requirement of foreign keys is the establishment of relationships between tables. It makes sure that data is linked across multiple tables and helps in storing and retrieving data.
-> Data Security: Foreign keys helps in improving the security of data by preventing unauthorized modifications or deletions of important data in the referenced table.
*/

-- Creating a foreign key
/* 
Syntax:
CREATE TABLE TABLE_NAME(
     COLUMN_NAME DATA_TYPE,
     COLUMN_NAME DATA_TYPE,
     FOREIGN KEY (COLUMN_NAME)
     REFERENCES REFERENCED_TABLE_NAME(REFERENCED_COLUMN_NAME));
*/
CREATE TABLE trades (
    trade_id INT(3) PRIMARY KEY,
    stock_id INT(3),
    client_id INT(3),
    broker_id INT(3),
    trade_date DATE,
    quantity INT(5),
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY(stock_id) REFERENCES stocks(stock_id),
    FOREIGN KEY(client_id) REFERENCES clients(client_id),
    FOREIGN KEY(broker_id) REFERENCES brokers(broker_id)
);

-- Adding Foreign key to an already existing table
/*
Syntax:
ALTER TABLE TABLE_NAME
ADD FOREIGN KEY (COLUMN_NAME)
REFERENCES REFERENCED_TABLE_NAME(REFERENCED_COLUMN_NAME));
*/
ALTER TABLE trades 
ADD FOREIGN KEY(stock_id) REFERENCES stocks(stock_id);

-- Removing Foreign Key from a table
/*
Syntax:
ALTER TABLE TABLE_NAME DROP FOREIGN KEY CONSTRAINT_NAME;
*/
ALTER TABLE trades DROP FOREIGN KEY trades_ibfk_1;

/*
NORMALISATION
Normalization is the process of minimizing redundancy from a relation or set of relations.
Redundancy in relation may cause insertion, deletion, and update anomalies. So, it helps to minimize the redundancy in relations. 
Normal forms are used to eliminate or reduce redundancy in database tables. 

Levels of Normalization
There are various levels of normalization. These are some of them: 
-> First Normal Form (1NF)
-> Second Normal Form (2NF)
-> Third Normal Form (3NF)
-> Boyce-Codd Normal Form (BCNF)

1NF - FIRST NORMAL FORM
It is a basic level of data organization in relational databases. It ensures a table structure that minimizes redundancy and improves data integrity.
A Table is in 1NF if:
-> There are only single valued attributes (atomic values)
-> No repeating groups */

CREATE TABLE stocks (
    stock_id INT(3) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    sector VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    available_shares INT(10)
);

    

-- 2NF (Second Normal Form):

/* ->Table must be in 1NF.
-> All non-key attributes (columns) must depend on the entire primary key.
-> If a table has a composite primary key, each non-key attribute must depend on the entire composite key, not just on part of it.
-> If any non-key attribute depends on only a part of a composite key, it violates 2NF and should be moved to a separate table along with the part of the key it depends on.*/


-> Example Violating 2NF:
CREATE TABLE trades (
    trade_id INT(3) PRIMARY KEY,
    stock_id INT(3),
    client_id INT(3),
    broker_id INT(3),
    trade_date DATE,
    quantity INT(5),
    total_amount DECIMAL(10,2) NOT NULL,
    client_city VARCHAR(50), -- This depends on client_id
    FOREIGN KEY(stock_id) REFERENCES stocks(stock_id),
    FOREIGN KEY(client_id) REFERENCES clients(client_id),
    FOREIGN KEY(broker_id) REFERENCES brokers(broker_id)
);




/*3NF (Third Normal Form):

-> Table must be in 2NF.
-> No transitive dependencies should exist.
-> Every non-key attribute must depend on the primary key, and only the primary key.
-> If a non-key attribute depends on another non-key attribute, it should be moved to a separate table along with the attribute it depends on.
*/
-- Example Violating 3NF:

CREATE TABLE trades (
    trade_id INT(3) PRIMARY KEY,
    stock_id INT(3),
    client_id INT(3),
    broker_id INT(3),
    trade_date DATE,
    quantity INT(5),
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY(stock_id) REFERENCES stocks(stock_id),
    FOREIGN KEY(client_id) REFERENCES clients(client_id),
    FOREIGN KEY(broker_id) REFERENCES brokers(broker_id)
);

CREATE TABLE clients (
    client_id INT(3) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT(3),
    city VARCHAR(50)
);

-- BCNF
-- Boyce-Codd Normal Form (BCNF) is a higher level of normalization than 3NF.
-- It eliminates some anomalies that can arise from non-trivial functional dependencies in 3NF relations.

-- Functional Dependency (FD):
-- A functional dependency exists when one attribute uniquely determines another attribute in a relation.

-- Non-Trivial Functional Dependency:
-- A functional dependency is non-trivial if the determining attribute is not a superkey.

-- Key and Superkey:
-- A superkey is a set of attributes that, taken collectively, uniquely identifies a tuple in a relation.
-- A key is a minimal superkey, meaning no proper subset of the key can uniquely identify a tuple.

--  Requirements for BCNF:
-- Every non-trivial functional dependency X → Y, X must be a superkey.
-- No non-trivial functional dependencies should exist between attributes that are not part of some candidate key.

-- Benefits:
-- BCNF ensures that the database is free from update anomalies, insertion anomalies, and deletion anomalies, thus maintaining data integrity.

-- Example: 
CREATE TABLE orders (
    oid INT(3) PRIMARY KEY,
    cid INT(3),
    pid INT(3),
    amt DECIMAL(10,2) NOT NULL,
    FOREIGN KEY(cid) REFERENCES clients(cid),
    FOREIGN KEY(pid) REFERENCES products(pid)
);


CREATE TABLE order_info (
    oid INT(3) PRIMARY KEY,
    amt DECIMAL(10,2) NOT NULL,
    FOREIGN KEY(oid) REFERENCES orders(oid)
);

CREATE TABLE order_details (
    oid INT(3),
    cid INT(3),
    pid INT(3),
    PRIMARY KEY(oid, cid, pid),
    FOREIGN KEY(oid) REFERENCES orders(oid),
    FOREIGN KEY(cid) REFERENCES clients(cid),
    FOREIGN KEY(pid) REFERENCES products(pid)
);

-- Since we have decomposed based on the functional dependency, the original functional dependencies are preserved.


-- QUESTIONS AND ANSWERS
-- ANOMALIES
-- What are potential data anomalies that could occur if the database is not normalized (specifically 1NF, 2NF, or 3NF)?
-- Answer:  Data anomalies are inconsistencies or redundancies that can arise in a non-normalized database. These anomalies can lead to data integrity issues, making it difficult to insert, update, or delete data accurately.

			Insertion Anomaly: Difficulty inserting complete data due to missing dependencies.
			Deletion Anomaly: Deleting data from one table can unintentionally affect data in another table.
			Updation Anomaly: Updating data in one table might require repetitive changes in other tables to maintain consistency.


-- 2. Candidate Keys and Primary Key:

Query: Write a query to display the stock information and choose the most appropriate attribute(s) as the primary key for the stocks table
SELECT stock_id, name, sector, price, available_shares
FROM stocks;


-- 3. Foreign Keys:


Query: Write a query that joins the Orders and Customer tables using the foreign key relationship. This query should retrieve order details (order ID, customer name, product ID) for a specific customer (e.g., customer ID 102).
ANSWER: 

SELECT t.trade_id, c.name, t.stock_id
FROM trades t
INNER JOIN clients c ON t.client_id = c.client_id
WHERE t.client_id = 102;


4. Normalization Levels (1NF, 2NF, 3NF):

Question: Describe the key differences between 1NF, 2NF, and 3NF.

Answer:

Normalization
1NF - First Normal Form
-> Multivalued attr should not be present
-> Primary key is present in the table
-> Repeating groups
-> Duplicate rows should not be there

2NF - Second Normal Form
-> Should be in 1NF
-> No partial dependency - 
All non key attr should be completely dependent
on primary key 
3NF 
Table must be in 2NF.
-> No transitive dependencies should exist.
-> Every non-key attribute must depend on the primary key, and only the primary key.
-> If a non-key attribute depends on another non-key attribute, it should be moved to a separate table along with the attribute it depends on.


 Boyce-Codd Normal Form (BCNF):

Question: How does BCNF differ from 3NF? When is it typically used?

BCNF (Boyce-Codd Normal Form) is a higher level of normalization compared to 3NF. It addresses a specific type of redundancy that 3NF might not eliminate.

Key Differences:

Dependency Rule:

3NF: Eliminates transitive dependencies where a non-key attribute relies on another non-key attribute.
BCNF: Every determinant (attribute or set of attributes that determines another attribute) in a table must be a candidate key. This ensures there are no hidden dependencies beyond the primary key.
Strictness: BCNF is stricter than 3NF, requiring an additional condition for eliminating certain types of redundancies.
