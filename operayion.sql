1. SELECT SUM(price) FROM products;

2. SELECT * FROM products WHERE price % 3 = 0;

3. SELECT product_name, price, price - (SELECT AVG(price) FROM products) AS price_difference FROM products;

4. SELECT * FROM products WHERE price >= 50000;

5. SELECT * FROM customers WHERE age <> 30;

6. SELECT * FROM orders WHERE order_amt <= 10000;

7. SELECT * FROM products WHERE location = 'Mumbai' AND stocklvl > 10;

9. SELECT * FROM customers WHERE city = 'Mumbai' OR c_id IN (SELECT c_id FROM orders WHERE order_amt > 20000);

10. SELECT * FROM orders WHERE pmt_mode <> 'upi' AND status = 'completed';
