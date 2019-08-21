-- List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees as e
LEFT JOIN salaries as s
ON e.emp_no = s.emp_no;

-- List employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '1986-01-01' AND hire_date < '1987-01-01'
ORDER BY hire_date;

-- List the manager of each department with the following information: department number, department name, 
--    the manager's employee number, last name, first name, and start and end employment dates.
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, e.hire_date, dm.to_date 
FROM dept_manager as dm
LEFT JOIN employees as e ON dm.emp_no = e.emp_no
LEFT JOIN departments as d ON dm.dept_no = d.dept_no;

-- List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name 
FROM employees as e
LEFT JOIN dept_emp as de ON e.emp_no = de.emp_no
LEFT JOIN departments as d ON d.dept_no = de.dept_no;
--331603 results from above query (results in duplicates such as rows 115/116)
--300024 rows in employees

-- List all employees whose first name is "Hercules" and last names begin with "B."
SELECT e.last_name, e.first_name
FROM employees as e
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name 
FROM employees as e
LEFT JOIN dept_emp as de ON e.emp_no = de.emp_no
LEFT JOIN departments as d ON d.dept_no = de.dept_no WHERE dept_name = 'Sales'
ORDER BY e.last_name;

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name 
FROM employees as e
LEFT JOIN dept_emp as de ON e.emp_no = de.emp_no
LEFT JOIN departments as d ON d.dept_no = de.dept_no WHERE dept_name = 'Sales' or dept_name = 'Development'
ORDER BY e.last_name;

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS "Count of Employee Last Names"
FROM employees
GROUP BY last_name
ORDER BY last_name DESC;

select * from employees where emp_no = 499942;
