Dawn Brenner
Data Analytics Bootcamp – June 10 Class
Homework – 09 – SQL - Employee Database: A Mystery in Two Parts

# Bonus Data Engineering Steps

>I performed the Data Modeling and Data Engineering steps together as my ERD program wrote the code based on the information I entered to create the tables in the ERD.  Below are the steps performed.

  - Created the tables and added their fields and associated data types based on the data observed.
  
  - Identified the common fields amongst the tables (emp_no and dept_no). 
  
  - Identified the relationships between the tables with the common fields: one-to-one, one-to-many, many-to-many. 
  
  - Selected employees/emp_no as a primary key with the emp_no field as foreign keys from the titles, salaries, dept_emp, and dept_manager tables. 
  
  - Selected departments/dept_no as a primary key with the dept_no field as foreign keys from  the dept_emp and dept_manager tables. 
  
  - Assigned the primary and foreign keys to the appropriate fields and exported the SQL script to run in pgAdmin.
  
  - Performed required queries as needed for the data analysis.
  
>Noteworthy to mention for the dates that I did not assume that to/from dates in tables are that employee's total employment time with the company, but rather the time in that department or management position.  As such, I used the hire date and from date to determine employment time.

