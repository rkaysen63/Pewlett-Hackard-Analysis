-- DELIVERABLE 1
-- Retrieve the emp_no, first_name, last_name from employees (probably current employees)
-- Retrieve the title, from_date, to_date from titles
-- Filter the data on the birth_date (1952 - 1955)
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;


-- count size of retirement_titles
SELECT COUNT (emp_no)
FROM retirement_titles;
---------------------------------------------------------
-- Use DISTINCT with ORDER BY to remove duplicate rows from retirement_titles
SELECT DISTINCT ON (emp_no) emp_no, 
	first_name, 
	last_name,
	title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- count size of unique_titles
SELECT COUNT (emp_no)
FROM unique_titles;
---------------------------------------------------------

-- count size of unique_titles
SELECT COUNT(emp_no)
FROM unique_titles;

---------------------------------------------------------
-- Retrieve the # of employees by their most recent job title who are about to retire.
SELECT 
	COUNT (title) as "count",
	title
FROM unique_titles
INTO retiring_titles
GROUP BY title
ORDER BY "count" DESC;

--------------------------------------------------------
-- DELIVERABLE 2
-- Create a Mentorship Eligibility table for current employees 
-- who were born between January 1, 1965 and December 31, 1965.
-- Used DISTINCT ON with ORDER BY to remove duplicate rows of titles.
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
    e.first_name,
    e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
LEFT JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
INNER JOIN titles as t
	ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, t.to_date DESC;
------------------------------------------------------------

-- Count number of employees eligible for mentoring.
SELECT COUNT(emp_no)
FROM mentorship_eligibility;

-------------------------------------------------
-- DELIVERABLE 3
-- Add department name to unique_titles for new table unique_dept
SELECT DISTINCT ON (ut.emp_no) ut.emp_no,
	ut.first_name, 
	ut.last_name,
	ut.title,
	d.dept_name
INTO unique_dept
FROM unique_titles AS ut
INNER JOIN dept_emp AS de
	ON (ut.emp_no=de.emp_no)
INNER JOIN departments AS d
	ON (de.dept_no=d.dept_no)
ORDER BY ut.emp_no, de.to_date;

--------------------------------------------------
-- Count how many titles within unique_titles may be retiring by dept.
SELECT dept_name As "Department", 
    title AS "Title", COUNT(title) AS "Total"
INTO rtrng_dept_title_count
FROM unique_dept
GROUP BY dept_name, title
ORDER BY "Department", "Title";

----------------------------------------------------
-- Add department name to mentorship_eligibility for new table mntrshp_el_dept.
SELECT DISTINCT ON (me.emp_no) me.emp_no,
	me.first_name, 
	me.last_name,
	me.title,
	d.dept_name
INTO mntrshp_elig_dept
FROM mentorship_eligibility AS me
INNER JOIN dept_emp AS de
	ON (me.emp_no=de.emp_no)
INNER JOIN departments AS d
	ON (de.dept_no=d.dept_no)
ORDER BY me.emp_no, de.to_date;

---------------------------------------------------
-- Count no. titles within ea dept eligible for mentoring
SELECT dept_name As "Department", 
    title AS "Title", COUNT(title) AS "Total"
INTO mnt_dept_title_count
FROM mntrshp_elig_dept
GROUP BY dept_name, title
ORDER BY "Department", "Title";

----------------------------------------------------


