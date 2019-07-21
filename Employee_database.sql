-- Database: SQL_Employee_Database

-- DROP DATABASE "SQL_Employee_Database";

CREATE DATABASE "SQL_Employee_Database"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
---Creating Employees table	
CREATE TABLE employees
(
	emp_no INT PRIMARY KEY NOT NULL,
	birth_date VARCHAR(30) NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	gender VARCHAR(1) NOT NULL,
	hire_date VARCHAR(30) NOT NULL
);

---Creating departments table
Create TABLE departments
(
	dept_no VARCHAR(4) primary key not null,
	dept_name VARCHAR(30) not null
);
--Creating department employees table
Create table dept_emp
(
	emp_no int not null,
	foreign key (emp_no) references employees(emp_no),
	dept_no varchar(4) not null,
	foreign key (dept_no) references departments(dept_no),
	from_date varchar(30) not null,
	to_date varchar(30) not null
);

---create departments managers table
Create table dept_manager
(
	dept_no Varchar(4) not null
	foreign key (dept_no) references departments(dept_no),
	emp_no int not null,
	foreign key (emp_no) references employees(emp_no),
	from_date varchar(30) not null,
	to_date varchar(30) not null
);

--Creating a salaries table

CREATE TABLE salaries
(
	emp_no int not null,
	foreign key (emp_no) references employees(emp_no),
	salary int not null,
	from_date varchar(30) not null,
	to_date varchar(30) not null
);

--create titles table
Create Table titles
(
	emp_no int not null,
	foreign key (emp_no) references employees(emp_no),
	title varchar(30) not null,
	from_date varchar(30) not null,
	to_date varchar(30) not null
);
---Queries of tables
--Question 1.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
from salaries as s
inner join employees as e on
e.emp_no = s.emp_no;

--Question 2.
SELECT * FROM employees
where hire_date Like '1986%';

---Question 3.
SELECT d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name, m.from_date
m.to_date
FROM departments AS d
inner join dept_manager as m on
m.dept_no = d.dept_no
join employees as e on
e.emp_no = m.emp_no;

--Question 4.
SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
from employees as e
inner join dept_emp as d on 
e.emp_no = d.emp_no
inner join departments as dp on
dp.dept_no = d.dept_no;

---Question 5.
SELECT * FROM employees
where first_name LIKE 'Hercules'
AND last_name LIKE 'B%';

--Question 6.
SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM employees as e 
inner join dept_emp as d on
e.emp_no = d.emp_no
inner join departments as dp no
dp.dept_no = d.dept_no
WHERE dp.dept_name LIKE 'Sales';

---Question 7.
SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM employees as e 
inner join dept_emp as d on
e.emp_no = d.emp_no
inner join departments as dp no
dp.dept_no = d.dept_no
WHERE dp.dept_name LIKE 'Development'
OR dp.dept_name LIKE 'Sales';

----Question 8.
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP  BY last_name
ORDER BY frquency DESC;