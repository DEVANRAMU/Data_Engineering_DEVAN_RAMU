CREATE DATABASE capstone_sql;
USE capstone_sql;

CREATE TABLE students (
student_id INT PRIMARY KEY,
student_name VARCHAR(100),
city VARCHAR(50),
age INT
);

CREATE TABLE enrollments (
enrollment_id INT PRIMARY KEY,
student_id INT,
course_name VARCHAR(100),
trainer VARCHAR(100),
fee DECIMAL(10,2)
);

INSERT INTO students VALUES
(1,'Aarav Sharma','Hyderabad',22),
(2,'Priya Reddy','Bangalore',23),
(3,'Rahul Verma','Mumbai',24),
(4,'Sneha Kapoor',NULL,21),
(5,'Vikram Singh','Chennai',25),
(6,NULL,'Delhi',22);

INSERT INTO enrollments VALUES
(101,1,'MySQL','Abdullah Khan',5000),
(102,1,'Python','Abdullah Khan',7000),
(103,2,'Power BI','Kiran',6000),
(104,3,'Azure Data Factory','Sneha',8000),
(105,NULL,'Excel','Rohan',3000),
(106,8,'Databricks','Ananya',9000);

-- Display student name and course name using INNER JOIN.
SELECT s.student_name,
		e.course_name
FROM students s inner join enrollments e 
ON s.student_id = e.student_id;

-- Display all students and their courses using LEFT JOIN.
SELECT s.student_name,
		e.course_name
FROM students s LEFT JOIN enrollments e
ON s.student_id = e.student_id;        

-- Display all courses even if no student exists using RIGHT JOIN.
SELECT e.course_name,
		s.student_name
FROM students s RIGHT JOIN enrollments e
ON s.student_id = e.student_id;

-- Simulate a FULL OUTER JOIN.
SELECT s.student_name, e.course_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
UNION
SELECT s.student_name, e.course_name
FROM students s
RIGHT JOIN enrollments e ON s.student_id = e.student_id;

-- Display all possible combinations of students and courses using CROSS JOIN. 
SELECT e.course_name,
		s.student_name
FROM students s CROSS JOIN enrollments e
ON s.student_id = e.student_id;

-- Display students from Hyderabad and the courses they enrolled in.
SELECT s.student_name, e.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
WHERE s.city = 'Hyderabad';

-- Display courses where the fee is greater than 6000.
SELECT course_name, fee
FROM enrollments
WHERE fee > 6000;

-- Find the total number of courses per student. 

SELECT s.student_name, COUNT(e.enrollment_id) AS total_courses
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_name;

-- Find the total fee paid by each student.
SELECT s.student_name, SUM(e.fee) AS total_fee_paid
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_name;

-- Display students who enrolled in more than one course. 

SELECT s.student_name, COUNT(e.enrollment_id) AS course_count
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_name
HAVING COUNT(e.enrollment_id) > 1;

--  Find trainers whose total collected fee is greater than 10000.
SELECT trainer, SUM(fee) AS total_collected
FROM enrollments
GROUP BY trainer
HAVING SUM(fee) > 10000;

-- Display cities having more than one student.
SELECT city, COUNT(student_id) AS student_count
FROM students
WHERE city IS NOT NULL
GROUP BY city
HAVING COUNT(student_id) > 1;

-- Capstone : Display student_name, city, and total_fee_paid for students whose total fee is greater than 5000, sorted by highest fee first.

SELECT s.student_name, s.city, SUM(e.fee) AS total_fee_paid
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_name, s.city
HAVING SUM(e.fee) > 5000
ORDER BY total_fee_paid DESC;