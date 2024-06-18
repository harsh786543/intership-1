0.
CREATE TABLE employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    position VARCHAR(50),
    salary DECIMAL(10, 2)
);

1.

INSERT INTO employee (id, name, position, salary) VALUES (1, 'Ryan Gosling', 'Engineer', 200000.00);

2.

UPDATE employee SET salary = 250000 WHERE id = 1;

3.

DELETE FROM employee WHERE id = 1;

4.

CREATE TABLE students (
    s_id INT PRIMARY KEY,
    s_name VARCHAR(255),
    c_id int
);

5.

CREATE TABLE courses (
    c_id INT PRIMARY KEY,
    c_name VARCHAR(255)
);

6.

ALTER TABLE students
ADD CONSTRAINT fk_course
FOREIGN KEY (c_id) REFERENCES courses(c_id);

7.

INSERT INTO courses (c_id, c_name) VALUES (1, 'MySQL');

INSERT INTO students (student_id, student_name, course_id) VALUES (1, 'Ryan', 1);

8.

SELECT * FROM products WHERE price > 5.00 AND expiry > '2024-03-23';

9.

UPDATE products SET last_updated = CURRENT_TIMESTAMP WHERE product_id = 1;

10.

DELETE FROM products WHERE stock < 50;










''':) Nice'''
