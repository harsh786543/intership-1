-- Create database
CREATE DATABASE share_market;
USE share_market;

CREATE TABLE stocks (
    stock_id INT(3) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    sector VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    available_shares INT(10)
);

CREATE TABLE brokers (
    broker_id INT(3) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    firm VARCHAR(50) NOT NULL
);

CREATE TABLE clients (
    client_id INT(3) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT(3),
    city VARCHAR(50)
);

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

CREATE TABLE payments (
    payment_id INT(3) PRIMARY KEY,
    trade_id INT(3),
    payment_date DATE,
    amount DECIMAL(10,2) NOT NULL,
    method VARCHAR(10) CHECK(method IN ('cash', 'credit', 'debit')),
    FOREIGN KEY(trade_id) REFERENCES trades(trade_id)
);

--Inserting values into stocks table
INSERT INTO stocks VALUES(1, 'Reliance Industries', 'Energy', 2450.75, 10000),
INSERT INTO stocks VALUES(2, 'Tata Consultancy Services', 'IT', 3200.50, 8000),
INSERT INTO stocks VALUES(3, 'HDFC Bank', 'Finance', 1450.00, 12000),
INSERT INTO stocks VALUES(4, 'Infosys', 'IT', 1575.25, 15000),
INSERT INTO stocks VALUES(5, 'ICICI Bank', 'Finance', 725.75, 20000);

--Inserting values into brokers table
INSERT INTO brokers VALUES(101, 'Rajesh Sharma', 'Kotak Securities'),
INSERT INTO brokers VALUES(102, 'Amit Patel', 'HDFC Securities'),
INSERT INTO brokers VALUES(103, 'Sunita Verma', 'ICICI Direct'),
INSERT INTO brokers VALUES(104, 'Neha Gupta', 'Sharekhan'),
INSERT INTO brokers VALUES(105, 'Pankaj Kapoor', 'Zerodha');

--Inserting values into clients table
INSERT INTO clients VALUES(201, 'Ravi Kumar', 30, 'Mumbai'),
INSERT INTO clients VALUES(202, 'Anita Singh', 28, 'Delhi'),
INSERT INTO clients VALUES(203, 'Rahul Jain', 35, 'Bangalore'),
INSERT INTO clients VALUES(204, 'Simran Kaur', 32, 'Chennai'),
INSERT INTO clients VALUES(205, 'Vijay Mehta', 40, 'Hyderabad');

--Inserting values into trades table
INSERT INTO trades VALUES
INSERT INTO trades VALUES(301, 1, 201, 101, '2024-06-01', 50, 122537.50),
INSERT INTO trades VALUES(302, 2, 202, 102, '2024-06-02', 30, 96015.00),
INSERT INTO trades VALUES(303, 3, 203, 103, '2024-06-03', 20, 29000.00),
INSERT INTO trades VALUES(304, 4, 204, 104, '2024-06-04', 25, 39381.25),
INSERT INTO trades VALUES(305, 5, 205, 105, '2024-06-05', 40, 29030.00);

-- Inserting values into payments table
INSERT INTO payments VALUES(401, 301, '2024-06-06', 122537.50, 'cash'),
INSERT INTO payments VALUES(402, 302, '2024-06-07', 96015.00, 'credit'),
INSERT INTO payments VALUES(403, 303, '2024-06-08', 29000.00, 'debit'),
INSERT INTO payments VALUES(404, 304, '2024-06-09', 39381.25, 'cash'),
INSERT INTO payments VALUES(405, 305, '2024-06-10', 29030.00, 'credit');


/*
--> Subqueries	
		Single row subqueries
		Multi row subqueries
		Correlated subqueries queries
--> Joins	
		Joins with subqueries
		Joins with aggregate functions
		Joins with date and time functions
--> Analytics functions / Advanced functions	
		RANK
		DENSE_RANK
		ROW_NUMBER
		CUME_DIST
		LAG
		LEAD
*/




-- SUBQUERIES:-

/* The single-row subquery returns one row. Multiple-row subqueries return sets of rows. 
These queries are commonly used to generate result sets that will be passed to a DML or SELECT statement for further processing. 
Both single-row and multiple-row subqueries will be evaluated once, before the parent query is run. 
"Single-row and multiple-row subqueries can be used in the WHERE and HAVING clauses of the parent query." */

/*CORELATED SUBQUERIES: SQL Correlated Subqueries are used to select data from a table referenced in the outer query.
The subquery is known as a correlated because the subquery is related to the outer query. In this type of queries,
 a table alias (also called a correlation name) must be used to specify which table reference is to be used.*/

-- SINGLE ROW SUBQUERIES:-
1: Find the broker who handled the trade with the highest total amount.
SELECT name 
FROM brokers 
WHERE broker_id = (
    SELECT broker_id 
    FROM trades 
    ORDER BY total_amount DESC 
    LIMIT 1
);


2: Find the stock with the highest price.
SELECT name 
FROM stocks 
WHERE price = (SELECT MAX(price) FROM stocks);

-- MULTIPLE-ROW SUBQUERIES
1: Find all clients who have placed a trade.
SELECT name 
FROM clients 
WHERE client_id IN (SELECT client_id FROM trades);

2: Find all clients who have placed a trade for stocks in the 'Technology' sector.
SELECT name 
FROM clients 
WHERE client_id IN (
    SELECT client_id 
    FROM trades 
    WHERE stock_id IN (
        SELECT stock_id 
        FROM stocks 
        WHERE sector = 'Technology'
    )
);


-- CORRELATED SUBQUERIES

1: Find stocks with a price higher than the average price in their sector.
SELECT name, price
FROM stocks s
WHERE price > (
    SELECT AVG(price) 
    FROM stocks 
    WHERE sector = s.sector
);

2: Find clients who have placed trades with a total amount exceeding the average trade amount.
SELECT name
FROM clients c
WHERE EXISTS (
    SELECT 1
    FROM trades t
    WHERE t.client_id = c.client_id
    GROUP BY t.client_id
    HAVING AVG(t.total_amount) > (
        SELECT AVG(total_amount) 
        FROM trades
    )
);


-- JOINS


#INNER JOIN with subquery :- SQL JOINS are used to combine more than two or more tables together to extract 
#						the useful data from all the tables. In this article, we will discuss INNER JOIN in SQL.

1: Retrieve the stocks with their corresponding trades where the stock price is greater than 1000.
SELECT s.name, t.trade_id, t.total_amount
FROM stocks s
INNER JOIN (
    SELECT * 
    FROM trades
) t ON s.stock_id = t.stock_id
WHERE s.price > 1000;

#2. LEFT JOIN with aggregate functions-The LEFT JOIN keyword returns all records from the left table (table1), and the 
#        matching records from the right table (table2). The result is 0 records from the right side, if there is no match.
EXAMPLE: Retrieve all stocks and their total trade amounts, even if there are no trades.
SELECT s.name, COALESCE(SUM(t.total_amount), 0) AS total_trade_amount
FROM stocks s
LEFT JOIN trades t ON s.stock_id = t.stock_id
GROUP BY s.name;



#3. RIGHT JOIN with date and time functions - The RIGHT JOIN keyword returns all records from the right table (table2),
#  and the matching records from the left table (table1). The result is 0 records from the left side, if there is no match.
EXAMPLE: Retrieve all trades and their corresponding payment details, even if there is no payment record.
SELECT t.trade_id, t.total_amount, p.amount, p.payment_date
FROM trades t
RIGHT JOIN payments p ON t.trade_id = p.trade_id;



-- Analytics functions / Advanced functions
-- 1. These function which we are going to use are called as Window Functions
-- 2. Window functions in SQL allow you to perform operations on a set of rows while still retaining the original structure of the data
-- 3. Unlike the GROUP BY clause, which collapses rows into fewer rows based on a grouping criterion.
-- 4. window functions keep all rows visible in the result, allowing you to add computed values that are based on a defined "window" of data.

# 1. RANK
-- RANK() gives a 'rank' to each row within a partition, based on an ordered set. If rows have the same value, they get the same rank. 
-- However, the ranks will have gaps when there are ties.
EXAMPLE: Display rank of stocks based on their prices.
SELECT stock_id, name, price, 
       RANK() OVER (ORDER BY price DESC) AS price_rank
FROM stocks;





#2. DENSE_RANK
-- DENSE_RANK() is similar to RANK(), but it does not create gaps when there are ties. 
-- Rows with the same value will get the same rank, but the next rank will be consecutive.
EXAMPLE: Display dense rank of stocks based on their prices.
SELECT stock_id, name, price, 
       DENSE_RANK() OVER (ORDER BY price DESC) AS price_rank
FROM stocks;

#3. ROW_NUMBER
-- ROW_NUMBER() assigns a unique row number to each record in a partitioned or ordered set. 
-- This always gives unique numbers, even if there are ties.
EXAMPLE: Find unique row numbers for the clients table.
SELECT ROW_NUMBER() OVER (ORDER BY age DESC) AS row_num, client_id, name, age, city
FROM clients;

#4. CUME_DIST
--  It shows the relative position of a row within a data set, indicating what fraction of the data set is at or below a particular value.
-- The value is always between 0 and 1.
-- The values which will have be closer to 0 will have better score and thus will be identified as being in top percentages
EXAMPLE: Find cumulative distribution of payments based on the amount spent.
SELECT trade_id, amount,
       CUME_DIST() OVER (ORDER BY amount) AS cumulative_distribution
FROM payments;


#5. LAG
-- The LAG() function provides access to a row at a specified physical offset prior to the current row within the partition.
-- It's often used to retrieve values from a previous row in the result set without using a self-join.
EXAMPLE: Find the previous price of stocks ordered by price in ascending order.
SELECT name, price, 
       LAG(price) OVER (ORDER BY price) AS previous_price
FROM stocks;


-- 4. LEAD
-- The LEAD() function provides access to a row at a specified physical offset after the current row within the partition.
-- It's useful for fetching values from subsequent rows in the result set without a self-join.
EXAMPLE: Find the next price of stocks ordered by price in ascending order.
SELECT name, price, 
       LEAD(price) OVER (ORDER BY price) AS next_price
FROM stocks;





