CREATE DATABASE company_training;

USE company_training;

CREATE TABLE employees (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(100),
department VARCHAR(50),
city VARCHAR(50)
);

CREATE TABLE projects (
project_id INT PRIMARY KEY,
emp_id INT,
project_name VARCHAR(100),
project_budget DECIMAL(12,2),
project_status VARCHAR(50)
);

INSERT INTO employees VALUES
(1, 'Rohan Mehta', 'IT', 'Hyderabad'),
(2, 'Sneha Iyer', 'IT', 'Bangalore'),
(3, 'Kiran Patel', 'Finance', 'Mumbai'),
(4, 'Ananya Das', 'HR', NULL),
(5, 'Rahul Sharma', 'IT', 'Delhi'),
(6, NULL, 'Marketing', 'Chennai');

INSERT INTO projects VALUES
(101, 1, 'AI Chatbot', 120000, 'Active'),
(102, 1, 'ML Prediction', 90000, 'Active'),
(103, 2, 'Data Warehouse', 150000, 'Active'),
(104, 3, 'Financial Dashboard', 80000, 'Completed'),
(105, NULL, 'Website Revamp', 60000, 'Pending'),
(106, 8, 'Mobile App', 100000, 'Active');

SELECT employees.emp_name,
		projects.project_name,
        projects.project_budget
FROM employees inner join projects 
ON employees.emp_id = projects.emp_id;

SELECT employees.emp_name,
		projects.project_id,
		projects.project_name,
        projects.project_budget,
        projects.project_status
FROM employees left join projects 
ON employees.emp_id = projects.emp_id;

-- To Show all projects even if employee does not exist.
SELECT 
    p.project_name, 
    e.emp_name
FROM 
    projects p
LEFT JOIN 
    employees e ON p.emp_id = e.emp_id;
    
-- Simulate ful outer join 
SELECT e.emp_name, p.project_name
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
UNION
SELECT e.emp_name, p.project_name
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id;

-- CROSS join
SELECT e.emp_name, p.project_name 
FROM employees e
CROSS JOIN projects p; 

-- Join with filtering

SELECT p.project_name, e.department
FROM projects p
JOIN employees e ON p.emp_id = e.emp_id
WHERE e.department = 'IT';

-- Showing all projects with budget>100000
SELECT project_name, project_budget 
FROM projects 
WHERE project_budget > 100000;

-- To Show employees from Hyderabad and their projects.
SELECT e.emp_name, e.city, p.project_name
FROM employees e
JOIN projects p ON e.emp_id = p.emp_id
WHERE e.city = 'Hyderabad';

-- Finding total number of projects per employee.
SELECT e.emp_name, COUNT(p.project_id) AS total_projects
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
GROUP BY e.emp_name;

-- Finding total project budget handled by each employee.
SELECT e.emp_name, SUM(p.project_budget) AS total_budget
FROM employees e
JOIN projects p ON e.emp_id = p.emp_id
GROUP BY e.emp_name; 

-- Finding average project budget per department.
SELECT e.department, AVG(p.project_budget) AS avg_budget
FROM employees e
JOIN projects p ON e.emp_id = p.emp_id
GROUP BY e.department; 

-- Showing total projects per department.
SELECT e.department, COUNT(p.project_id) AS total_projects
FROM employees e
JOIN projects p ON e.emp_id = p.emp_id
GROUP BY e.department; 

-- Showing total budget per department
SELECT e.department, SUM(p.project_budget) AS total_dept_budget
FROM employees e
JOIN projects p ON e.emp_id = p.emp_id
GROUP BY e.department; 

-- Showing number of employees per city.
SELECT city, COUNT(emp_id) AS employee_count
FROM employees
WHERE city IS NOT NULL
GROUP BY city;

-- Showing employees handling more than 1 project.
SELECT e.emp_name, COUNT(p.project_id) AS project_count
FROM employees e
JOIN projects p ON e.emp_id = p.emp_id
GROUP BY e.emp_name
HAVING COUNT(p.project_id) > 1;

-- Show departments with total budget greater than 150000.
SELECT e.department, SUM(p.project_budget) AS total_dept_budget
FROM employees e
JOIN projects p ON e.emp_id = p.emp_id
GROUP BY e.department
HAVING total_dept_budget>150000; 

-- Show employees with total budget greater than 100000.
SELECT e.emp_name, SUM(p.project_budget) AS total_emp_budget
FROM employees e
JOIN projects p ON e.emp_id = p.emp_id
GROUP BY e.emp_name
HAVING total_emp_budget>100000; 


-- Capstone Project : Show employee name, department, and total project budget for employees whose total project budget > 100000, sorted by highest budget.
SELECT e.emp_name, e.department, SUM(p.project_budget) AS total_budget
FROM employees e
JOIN projects p ON e.emp_id = p.emp_id
GROUP BY e.emp_name, e.department
HAVING SUM(p.project_budget) > 100000
ORDER BY total_budget DESC;