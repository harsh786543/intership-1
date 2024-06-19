-- Creat database
CREATE DATABASE share_market;

-- Use database
USE share_market;

-- Create table of Stocks - stock_id, name, sector, price, available_shares
CREATE TABLE stocks (
    stock_id INT(3) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    sector VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    available_shares INT(10)
);

-- Create table of Brokers - broker_id, name, firm
CREATE TABLE brokers (
    broker_id INT(3) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    firm VARCHAR(50) NOT NULL
);

-- Create table of Clients - client_id, name, age, city
CREATE TABLE clients (
    client_id INT(3) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT(3),
    city VARCHAR(50)
);

-- Create table of Trades - trade_id, stock_id, client_id, broker_id, trade_date, quantity, total_amount
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

-- Create table of Payments - payment_id, trade_id, payment_date, amount, method (cash, credit, debit)
CREATE TABLE payments (
    payment_id INT(3) PRIMARY KEY,
    trade_id INT(3),
    payment_date DATE,
    amount DECIMAL(10,2) NOT NULL,
    method VARCHAR(10) CHECK(method IN ('cash', 'credit', 'debit')),
    FOREIGN KEY(trade_id) REFERENCES trades(trade_id)
);

-- Inserte values into stocks table
INSERT INTO stocks VALUES (1, 'AAPL', 'Technology', 150.00, 1000);
INSERT INTO stocks VALUES (2, 'GOOGL', 'Technology', 2800.00, 500);
INSERT INTO stocks VALUES (3, 'AMZN', 'E-commerce', 3300.00, 300);
INSERT INTO stocks VALUES (4, 'TSLA', 'Automotive', 700.00, 700);
INSERT INTO stocks VALUES (5, 'MSFT', 'Technology', 290.00, 800);

-- Inserte values into brokers table
INSERT INTO brokers VALUES (1, 'vikas', 'zarodha');
INSERT INTO brokers VALUES (2, 'saket', 'growth');
INSERT INTO brokers VALUES (3, 'vishal', 'angle one');

-- Inserting values into clients table
INSERT INTO clients VALUES (1, 'akshat', 20, 'mumbai');
INSERT INTO clients VALUES (2, 'adithya', 25, 'banglore');
INSERT INTO clients VALUES (3, 'manak', 35, 'chhenai');
INSERT INTO clients VALUES (4, 'vasu', 28, 'vapi');

-- Inserting values into trades table
INSERT INTO trades VALUES (1001, 1, 1, 1, '2023-03-03', 10, 1500.00);
INSERT INTO trades VALUES (1002, 2, 2, 2, '2023-03-05', 5, 14000.00);
INSERT INTO trades VALUES (1003, 3, 3, 3, '2023-04-07', 2, 6600.00);
INSERT INTO trades VALUES (1004, 4, 4, 1, '2023-04-10', 3, 2100.00);

-- Inserting values into payments table
INSERT INTO payments VALUES (1, 1001, '2024-06-02', 1500.00, 'cash');
INSERT INTO payments VALUES (2, 1002, '2024-06-06', 14000.00, 'credit');
INSERT INTO payments VALUES (3, 1003, '2024-06-08', 6600.00, 'debit');

-- Displaying details of stocks table
SELECT * FROM stocks;

-- Displaying details of brokers table
SELECT * FROM brokers;

-- Displaying details of clients table
SELECT * FROM clients;

-- Displaying details of trades table
SELECT * FROM trades;

-- Displaying details of payments table
SELECT * FROM payments;

-- 1. Inner Join -> Matching values from both tables should be present
-- For example: For getting the name of clients who made a trade, we need to inner join clients and trades table

SELECT clients.client_id, name, trades.trade_id 
FROM trades 
INNER JOIN clients ON trades.client_id = clients.client_id;

-- Example 2: Now getting the name of the clients and the stocks they traded, we need to inner join trades, stocks, and clients table

SELECT clients.client_id, name, stocks.stock_id, stocks.name AS stock_name, trade_id 
FROM trades
INNER JOIN stocks ON trades.stock_id = stocks.stock_id
INNER JOIN clients ON trades.client_id = clients.client_id;

-- 2. Left Outer Join -> All the rows from the left table should be present and matching rows from the right table are present
-- Example: Getting the stock_id, stock name, and trade_id of all stocks, we need to left join stocks and trades table

SELECT stocks.stock_id, stocks.name, trade_id 
FROM stocks
LEFT JOIN trades ON trades.stock_id = stocks.stock_id;

-- 3. Right Join -> All the rows from the right table should be present and only matching rows from the left table are present 
-- Example: Displaying trade details along with client information, we need to right join trades and clients table

SELECT * 
FROM trades 
RIGHT JOIN clients ON clients.client_id = trades.client_id;

-- 4. Full Join -> All the rows from both the tables should be present 
-- Note: MySQL does not support full join we need to perform "UNION" operation between the results obtained from left and right join
-- Example: Displaying the details of all the trades and stocks

SELECT trades.trade_id, stocks.stock_id, stocks.name AS stock_name, trade_date 
FROM trades
LEFT JOIN stocks ON trades.stock_id = stocks.stock_id
UNION
SELECT trades.trade_id, stocks.stock_id, stocks.name AS stock_name, trade_date 
FROM trades
RIGHT JOIN stocks ON trades.stock_id = stocks.stock_id;

-- 5. Self Join -> It is a regular join, but the table is joined by itself
-- Example: Displaying brokers and their firms (assuming brokers can work with each other), we need to self join the brokers table

SELECT b1.name AS Broker, b2.name AS Partner, b1.firm 
FROM brokers b1
INNER JOIN brokers b2 ON b1.broker_id != b2.broker_id AND b1.firm = b2.firm;

-- 6. Cross Join -> It is used to view all the possible combinations of the rows of one table and with all the rows from the second table
-- Example: Displaying all the details of clients and trades

SELECT clients.client_id, name, trades.trade_id, trade_date 
FROM clients
CROSS JOIN trades;

-- ***************************************************** Practice Questions *******************************************

-- Q1. Display details of all trades involving 'AAPL' stock

SELECT * 
FROM trades 
LEFT JOIN stocks ON trades.stock_id = stocks.stock_id
WHERE stocks.name = 'AAPL';

-- Q2. Display details of all trades where payment was made through 'credit'

SELECT * 
FROM trades
RIGHT JOIN payments ON trades.trade_id = payments.trade_id
WHERE method = 'credit';

-- Q3. Display trade_id, trade_date, client name, stock name of trades for clients aged below 30 years

SELECT trades.trade_id, trade_date, clients.name, stocks.name AS stock_name 
FROM trades
INNER JOIN stocks ON trades.stock_id = stocks.stock_id
INNER JOIN clients ON trades.client_id = clients.client_id
WHERE clients.age < 30;

-- Q4. Display trade_id, trade_date, client name, stock name of trades for clients aged below 30 years and stocks in the 'Technology' sector

SELECT trades.trade_id, trade_date, clients.name, stocks.name AS stock_name 
FROM trades
INNER JOIN stocks ON trades.stock_id = stocks.stock_id
INNER JOIN clients ON trades.client_id = clients.client_id
WHERE clients.age < 30 AND stocks.sector = 'Technology';

-- Q5. Display trade_id, trade_date, client name, stock name of trades where the stock is out of available shares

SELECT trades.trade_id, trade_date, clients.name, stocks.name AS stock_name 
FROM trades
INNER JOIN stocks ON trades.stock_id = stocks.stock_id
INNER JOIN clients ON trades.client_id = clients.client_id
WHERE stocks.available_shares = 0;

-- Q6. Display client details along with the stocks they traded and their trade dates

SELECT clients.client_id, clients.name, stocks.name AS stock_name, trades.trade_date 
FROM trades
INNER JOIN clients ON trades.client_id = clients.client_id
INNER JOIN stocks ON trades.stock_id = stocks.stock_id;
