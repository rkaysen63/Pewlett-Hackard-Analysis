-- Joining departments and dept_manager tables
SELECT departments.dept_name,
    dept_manager.emp_no,
    dept_manager.from_date,
    dept_manager.to_date
	FROM departments
	INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining departments and dept_manager tables using aliases
SELECT d.dept_name,
	   dm.emp_no,
	   dm.from_date,
	   dm.to_date
	   FROM departments as d
	   INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
	retirement_info.last_name,
    dept_emp.to_date
	FROM retirement_info
	LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Joining retirement_info and dept_emp tables using aliases
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
	FROM retirement_info as ri
	LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

-- Join retirement_info and dept_emp for list of all 
-- retirement-eligible employees still employed
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

SELECT * FROM current_emp

-- Employee count by department number
-- and order by dept_no
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Create a table for retiree count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO retire_count_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Determine most recent date on list
SELECT * FROM salaries
ORDER BY to_date DESC;

-- Determine most recent date on list
SELECT * FROM dept_emp
ORDER BY to_date DESC;

-- Creat temporary table with empl_no, first_name, last_name, gender from employees
-- joined with salary table for salary and to dept_emp for to_date
SELECT e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- List of managers per department
SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp AS ce
		ON (dm.emp_no = ce.emp_no);


-- Create dept_info table
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no);
	
--Create sales_dept_info
SELECT e.emp_no, 
	e.first_name, 
	e.last_name, 
	d.dept_name
--INTO sales_dept_info
FROM employees as e
	INNER JOIN dept_emp as de
		ON (e.emp_no = de.emp_no)
	INNER JOIN departments as d
		ON (de.dept_no = d.dept_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01')
AND (de.dept_no = 'd007');


--Create sales_dept_info, can this be done with current_emp?
SELECT ce.emp_no, 
	ce.first_name, 
	ce.last_name, 
	d.dept_name
--INTO sales_dept_info
FROM current_emp as ce
	INNER JOIN dept_emp as de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments as d
		ON (de.dept_no = d.dept_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.dept_no = 'd007');


--Create sales_dept_info, can this be done with current_emp?
SELECT ce.emp_no, 
	ce.first_name, 
	ce.last_name, 
	d.dept_name
--INTO sales_dept_info
FROM current_emp as ce
	INNER JOIN dept_emp as de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments as d
		ON (de.dept_no = d.dept_no)
WHERE (d.dept_name = 'sales');

--Create sales_dept_info, can this be done with current_emp?  
SELECT ce.emp_no, 
	ce.first_name, 
	ce.last_name, 
	d.dept_name
--INTO sales_dept_info
FROM current_emp as ce
	INNER JOIN dept_emp as de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments as d
		ON (de.dept_no = d.dept_no)
WHERE (de.dept_no = 'd007')
ORDER BY CE.last_name DESC;
--yikes, different results!


--Create sales_n_development
SELECT ce.emp_no, 
	ce.first_name, 
	ce.last_name, 
	d.dept_name
--INTO sales_n_development
FROM current_emp as ce
	INNER JOIN dept_emp as de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments as d
		ON (de.dept_no = d.dept_no)
WHERE de.dept_no IN ('d007', 'd005');