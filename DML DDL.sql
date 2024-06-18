1. CREATE TABLE employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    position VARCHAR(50),
    salary DECIMAL(10, 2)
);

2. INSERT INTO employee (id, name, position, salary) VALUES (1, 'Ryan Gosling', 'Engineer', 200000.00);

3. UPDATE employee SET salary = 250000 WHERE id = 1;

4. DELETE FROM employee WHERE id = 1;

5. CREATE TABLE students (
    s_id INT PRIMARY KEY,
    s_name VARCHAR(255),
    c_id int
);

6. CREATE TABLE courses (
    c_id INT PRIMARY KEY,
    c_name VARCHAR(255)
);

7. ALTER TABLE students
   ADD CONSTRAINT fk_course
   FOREIGN KEY (c_id) REFERENCES courses(c_id);

8. INSERT INTO courses (c_id, c_name) VALUES (1, 'MySQL');
   INSERT INTO students (student_id, student_name, course_id) VALUES (1, 'Ryan', 1);

9. SELECT * FROM products WHERE price > 5.00 AND expiry > '2024-03-23';

10. UPDATE products SET last_updated = CURRENT_TIMESTAMP WHERE product_id = 1;

11. DELETE FROM products WHERE stock < 50;










''':) Nice'''
