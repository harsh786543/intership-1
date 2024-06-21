use share_market;
-- DELIMITER COMMAND:
/*
1. Purpose: 
   - The DELIMITER command is used to change the standard delimiter(like a semicolon (;)), to a different character. 
2. Usage:
   - When defining stored procedures, functions, or other multi-statement constructs that contain semicolons within their body.
   - This allows you to specify a different character as the delimiter to avoid prematurely terminating the entire statement.
3. Syntax:
   - The syntax for the DELIMITER command is as follows:
     DELIMITER new_delimiter;
4. Example:
   - Changing the delimiter to //:
     DELIMITER //
     CREATE PROCEDURE procedure_name()
     BEGIN
			SQL statements
     END //
     DELIMITER ;

5. Resetting the delimiter:
   - After defining the stored procedure or function, you should reset the delimiter back to the standard semicolon (;) using:
     DELIMITER ;
*/

-- DETERMINISTIC: 
 /*
DETERMINISTIC indicates that the function will always return the same result for the same input values.
If the function contains any non-deterministic elements (e.g., calls to functions that return different values each time they are called),
you should omit this keyword.
*/


-- PROCEDURES 
 /*  A procedure is a set of SQL statements that can be saved and reused.
  ~ Procedures can have input parameters (IN) and output parameters (OUT).
  ~ Procedures do not return a value.
  ~ A procedure is a prepared SQL code that you can save, so the code can be reused over and over again.
  ~ So if you have an SQL query that you write over and over again, save it as a stored procedure, and then just call it to execute it. */
 
 
-- CREATE PROCEDURE
/* 
Procedures in SQL allow you to encapsulate a series of SQL statements into a reusable unit.
~ Syntax:
	DELIMITER //
		CREATE PROCEDURE procedure_name(parameter1 datatype, parameter2 datatype, ...)
		BEGIN
			Procedure logic goes here
		END //
	DELIMITER ;
*/ 

-- EXAMPLE:
Create a procedure to select all stocks:
DELIMITER //
CREATE PROCEDURE select_all_stocks()
BEGIN
    SELECT * FROM stocks;
END//
DELIMITER ;


-- EXECUTING PROCEDURES
/*
Once a procedure is created, you can execute it using the CALL statement followed by the procedure name and any required parameters.
~ Syntax:
-- CALL procedure_name(parameter1, parameter2, ...);
*/

CALL select_all_stocks();


-- DROPPING PROCEDURES
/*
If a procedure is no longer needed, it can be dropped using the DROP PROCEDURE statement.
~ Syntax: 
	DROP PROCEDURE procedure_name;
*/

-- EXAMPLE:
-- Dropping select_all_stocks
DROP PROCEDURE select_all_stocks;


-- FUNCTIONS
/*
A function is a reusable block of code that performs a specific task and can return a value.
Functions are similar to procedures, but procedures do not return values.
Functions can have input parameters (IN) but cannot have output parameters.
Input parameters allow you to pass data into the function, and the function can use that data to perform its task.
*/

-- FUNCTION CREATION
/*
To create a function, you need to define its name, input parameters (if any), and the data type of the value it returns.
The function logic (the code that performs the task) goes inside the BEGIN and END blocks.

Syntax:
CREATE FUNCTION function_name(parameter1 data_type, parameter2 data_type, ...)
RETURNS return_data_type
AS
BEGIN
    -- Function logic here
END;
*/

-- EXAMPLE:
1. Create a function to calculate total revenue from completed trades
DELIMITER //
CREATE FUNCTION get_total_revenue()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_revenue DECIMAL(10,2);
    SELECT SUM(p.amount) INTO total_revenue
    FROM payments p
    INNER JOIN trades t ON p.trade_id = t.trade_id
    WHERE t.total_amount > 0; 
    RETURN total_revenue;
END//
DELIMITER ;





-- FUNCTION EXECUTION
/*
To execute (call) a function, you use the SELECT statement along with the function name and any required input parameters.
Syntax:
SELECT function_name(parameter1, parameter2, ...);
*/

-- EXAMPLE:
SELECT get_total_revenue();

-- DROPPING FUNCTION
/*
If you no longer need a function, you can drop (delete) it using the DROP FUNCTION statement.
Syntax:
DROP FUNCTION [IF EXISTS] function_name;
The IF EXISTS clause is optional and allows you to avoid an error if the function doesn't exist.
*/

-- EXAMPLE:
DROP FUNCTION IF EXISTS get_total_revenue;

-- IN
/* 
This In is a  part of procedures
IN parameters in MySQL stored procedures allow you to pass values into the procedure.
These values are read-only within the procedure and cannot be modified
 */
 
/* 
~ Syntax for IN
 CREATE PROCEDURE procedure_name(IN parameter_name data_type)
 BEGIN
    -- Procedure logic using parameter_name
    END;
*/

-- Creating procedure with IN
DELIMITER //
CREATE PROCEDURE get_stock_details(IN stock_id INT)
BEGIN
    SELECT * FROM stocks WHERE stock_id = stock_id;
END//
DELIMITER ;

CALL get_stock_details(5);

-- OUT
/* 
This OUT is a  part of procedures
 OUT  OUT parameters in MySQL stored procedures allow you to return values from a procedure. 
These values can be accessed by the calling program after the procedure execution. 
*/

/* 
~ Syntax
 CREATE PROCEDURE procedure_name(OUT parameter_name data_type)
 BEGIN
    -- Procedure logic using parameter_name
 END;
*/

-- Create the procedure to get product count using OUT
DELIMITER //
CREATE PROCEDURE get_stock_count(OUT total_count INT)
BEGIN
    SELECT COUNT(*) INTO total_count FROM stocks;
END//
DELIMITER ;

CALL get_stock_count(@count);
SELECT @count AS total_stocks;



-- CURSOR
/*
	1. Purpose:
		- Cursors in SQL are used to retrieve and process rows one by one from the result set of a query.
	2. Declaration:
		- Cursors are declared using the DECLARE CURSOR statement, specifying the SELECT query whose result set will be processed.
	3. Opening:
		- A cursor must be opened using the OPEN statement before fetching rows.
		- Opening a cursor positions the cursor before the first row.
	4. Fetching:
		- Rows from the result set are fetched one by one using the FETCH statement.
		- Each fetch operation advances the cursor to the next row in the result set.
	5. Closing:
		- After processing all rows, the cursor should be closed using the CLOSE statement.
		- Closing a cursor releases the resources associated with the result set and frees memory.
*/

/*
~ SYNTAX:

DECLARE cursor_name CURSOR FOR
SELECT column1, column2, ... 
FROM table_name 
WHERE condition;

OPEN cursor_name;

FETCH cursor_name INTO variable1, variable2, ...;

WHILE (condition) DO
    -- Process fetched row here
    -- Use fetched values stored in variables
    FETCH cursor_name INTO variable1, variable2, ...;
END WHILE;

CLOSE cursor_name;
*/

/*There exists two type cursor based on their creation by user or not one is user-defined and other is pre-defined */

/*
~ User-Defined Cursors:
	1. Purpose:
		- User-defined cursors are declared by the user to process rows retrieved from a query result set.
		- They are particularly useful when you need to perform custom operations on individual rows.

	2. Declaration:
		- User-defined cursors are declared using the DECLARE CURSOR statement, specifying the SELECT query whose result set will be processed.
		- This allows the user to define custom logic for fetching and processing rows.

	3. Opening, Fetching, and Closing:
		- User-defined cursors follow a similar process of opening, fetching, and closing as predefined cursors.
		- After declaring and opening the cursor, the user fetches rows one by one and processes them as needed.
		- Finally, the cursor is closed to release resources.
*/

-- EXAMPLE:
DELIMITER //
CREATE PROCEDURE calc_total_electronics_price(OUT total_price DECIMAL(10,2))
BEGIN
    SELECT SUM(price) INTO total_price
    FROM stocks
    WHERE sector = 'Electronics';
END//
DELIMITER ;

CALL calc_total_electronics_price(@total);
SELECT @total AS total_electronics_price;


/* 
~ Pre-defined Cursors:
	1. Purpose:
		- Predefined cursors are system-defined cursors provided by the DBMS.
		- They are often associated with built-in functions or stored procedures that return result sets.

	2. Usage:
		-Predefined cursors are commonly used with predefined functions or procedures to process result sets returned by these functions.
		- Examples of predefined cursors include cursors used with aggregate functions like COUNT(), SUM(), or with system-defined stored procedures.
*/

-- EXAMPLE:
DELIMITER //
CREATE PROCEDURE print_stock_names()
BEGIN
    DECLARE stock_name VARCHAR(100);
    DECLARE done INT DEFAULT FALSE;
    DECLARE stock_cursor CURSOR FOR SELECT name FROM stocks;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN stock_cursor;

    get_names: LOOP
        FETCH stock_cursor INTO stock_name;
        IF done THEN
            LEAVE get_names;
        END IF;
        SELECT stock_name;
    END LOOP get_names;

    CLOSE stock_cursor;
END//
DELIMITER ;


CALL print_stock_names();


-- PRACTICE QUESTIONS 

1. selects all records from the brokers table, and then call the procedure.
DELIMITER //
CREATE PROCEDURE select_all_brokers()
BEGIN
    SELECT * FROM brokers;
END//
DELIMITER ;

CALL select_all_brokers();

2. Function to calculate total revenue from trades for a specific client
DELIMITER //
CREATE FUNCTION get_client_revenue(client_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_revenue DECIMAL(10,2);
    SELECT SUM(p.amount) INTO total_revenue
    FROM payments p
    INNER JOIN trades t ON p.trade_id = t.trade_id
    WHERE t.client_id = client_id;
    RETURN total_revenue;
END//
DELIMITER ;

SELECT get_client_revenue(1);

3. Procedure with an IN parameter to retrieve trades for a specific broker
DELIMITER //
CREATE PROCEDURE get_trades_for_broker(IN broker_id INT)
BEGIN
    SELECT * FROM trades WHERE broker_id = broker_id;
END//
DELIMITER ;

CALL get_trades_for_broker(2);

4. Procedure with an OUT parameter to get the count of clients
DELIMITER //
CREATE PROCEDURE get_client_count(OUT total_count INT)
BEGIN
    SELECT COUNT(*) INTO total_count FROM clients;
END//
DELIMITER ;

CALL get_client_count(@count);
SELECT @count AS total_clients;

5. Use the predefined SUM() cursor to calculate the total price of all stocks in a specific sector
DELIMITER //
CREATE PROCEDURE calc_total_technology_price(OUT total_price DECIMAL(10,2))
BEGIN
    SELECT SUM(price) INTO total_price
    FROM stocks
    WHERE sector = 'Technology';
END//
DELIMITER ;

CALL calc_total_technology_price(@total);
SELECT @total AS total_technology_price;


