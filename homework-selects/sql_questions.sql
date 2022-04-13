-- Write a query to display:
-- 1. the first name, last name, salary, and job grade for all employees.
SELECT
    first_name,
    last_name,
    salary,
    job_title
FROM employees e
    LEFT JOIN jobs j
        ON j.job_id = e.job_id;

SELECT
    first_name,
    last_name,
    salary,
    job_title
FROM employees e
    JOIN jobs j
        ON j.job_id = e.job_id;
-- 2. the first and last name, department, city, and state province for each employee.
SELECT
    first_name,
    last_name,
    department_name,
    city,
    state_provINce
FROM employees e
    LEFT JOIN departments d
        ON d.department_id = e.department_id
    LEFT JOIN locatiONs l
        ON l.locatiON_id = d.locatiON_id;


-- 3. the first name, last name, department number and department name, for all employees for departments 80 OR 40.
SELECT
    e.first_name,
    e.last_name,
    d.department_name,
    d.department_id
FROM employees e
    LEFT JOIN departments d
        ON d.department_id = e.department_id
WHERE
    d.department_id = 80 OR
    d.department_id = 40;

SELECT
    e.first_name,
    e.last_name,
    d.department_name,
    d.department_id
FROM employees e
    LEFT JOIN departments d
        ON d.department_id = e.department_id
WHERE d.department_id IN (80, 40);

-- 4. those employees who cONtain a letter z  to their first name and also display their last name, department, city, and state province.
SELECT
    last_name,
    department_name,
    city,
    state_provINce
FROM employees e
    LEFT JOIN departments d
        ON d.department_id = e.department_id
    LEFT JOIN locatiONs l
        ON l.locatiON_id = d.locatiON_id
WHERE e.first_name LIKE '%z%';

SELECT
    last_name,
    department_name,
    city,
    state_provINce
FROM employees e
    LEFT JOIN departments d
        ON d.department_id = e.department_id
    LEFT JOIN locatiONs l
        ON l.locatiON_id = d.locatiON_id
WHERE INstr(e.first_name, 'z') > 0;

-- 5. the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
SELECT
    first_name,
    last_name,
    salary
FROM employees
WHERE salary<(
    SELECT salary
    FROM employees
    WHERE employee_id = 182
);

-- 6. the first name of all employees including the first name of their manager.
SELECT
    e.first_name,
    d.first_name
FROM employees e
    JOIN employees d
        ON e.manager_id = d.employee_id;

-- 7. the first name of all employees and the first name of their manager including those who does NOT working under any manager.
SELECT
    e.first_name,
    d.first_name
FROM employees e
    LEFT JOIN employees d
        ON e.manager_id = d.employee_id;

-- 8. the details of employees who manage a department.
SELECT *
FROM employees
WHERE employee_id IN(SELECT manager_id FROM employees);

-- 9. the first name, last name, and department number for those employees who works IN the same department as the employee who holds the last name as Taylor.
SELECT
    first_name,
    last_name,
    department_id
FROM employees
WHERE department_id IN(
    SELECT department_id
    FROM employees
    WHERE last_name = 'Taylor'
);

--10. the department name and number of employees IN each of the department.
SELECT
    department_name,
    count(*) "number of employees"
FROM departments d
    RIGHT JOIN employees e
        ON e.department_id=d.department_id
GROUP BY department_name;

--11. the name of the department, average salary and number of employees working IN that department who got commissiON.
SELECT
    department_name,
    avg(salary) "average salary",
    count(employee_id) "number of employees"
FROM departments d
    JOIN employees e
        ON e.department_id=d.department_id
WHERE commissiON_pct IS NOT NULL
GROUP BY department_name;

--12. job title and average salary of employees.
SELECT
    job_title,
    avg(salary) "average salary"
FROM jobs j
    JOIN employees e
        ON e.job_id = j.job_id
GROUP BY job_title;

--13. the country name, city, and number of those departments WHERE at least 2 employees are working.
SELECT
    country_name,
    city,
    count(department_name) "number of departments with at leasr 2 employees"
FROM locatiONs
    JOIN countries c
         ON c.country_id = l.country_id
    JOIN departments d
         ON d.locatiON_id = l.locatiON_id
    JOIN employees e
         ON e.department_id=d.department_id
GROUP BY
    country_name,
    city
HAVING count(department_name) > 1;

--14. the employee ID, job name, number of days worked IN for all those jobs IN department 80.
SELECT
    employee_id,
    job_title,
    sysdate - hire_date "number of days worked IN"
FROM employees
    JOIN jobs
        ON e.job_id = j.job_id
WHERE department_id = 80;

--15. the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
SELECT first_name || ' ' || last_name name
FROM employees
WHERE salary > (
    SELECT salary
    FROM employees
    WHERE employee_id = 163
);

SELECT cONcat(cONcat(first_name, ' '), last_name) name
FROM employees
WHERE salary > (
    SELECT salary
    FROM employees
    WHERE employee_id = 163
);

--16. the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.
SELECT
    employee_id,
    first_name || ' ' || last_name name
FROM employees
WHERE salary > (SELECT avg(salary) "average salary" FROM employees);

--17. the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.
SELECT
    employee_id,
    first_name || ' ' || last_name name,
    salary
FROM employees
WHERE manager_id =(
    SELECT employee_id
    FROM employees
    WHERE first_name = 'Payam'
);

--18. the department number, name ( first name and last name ), job and department name for all employees IN the Finance department.
SELECT
    department_id,
    first_name || ' ' || last_name name,
    job_title,
    department_name
FROM employees
    JOIN departments
         ON e.department_id=d.department_id
    JOIN jobs
         ON e.job_id = j.job_id
WHERE department_name = 'FINance';

--19. all the informatiON of an employee whose id is any of the number 134, 159 and 183.
SELECT *
FROM departments d
    JOIN employees e
         ON e.department_id=d.department_id
    JOIN jobs j
         ON e.job_id = j.job_id
    JOIN locatiONs l
         ON d.locatiON_id = l.locatiON_id
    JOIN job_history jh
         ON jh.employee_id = e.employee_id
WHERE employee_id IN (134, 159, 183);
--20. all the informatiON of the employees whose salary is within the range of smallest salary and 2500.
SELECT *
FROM departments d
    JOIN employees e
         ON e.department_id=d.department_id
    JOIN jobs j
         ON e.job_id = j.job_id
    JOIN locatiONs l
         ON d.locatiON_id = l.locatiON_id
    JOIN job_history jh
         ON jh.employee_id = e.employee_id
WHERE salary > (SELECT mIN(salary) "mINimal salary" FROM employees)
  AND salary < 2500;
--21. all the informatiON of the employees who does NOT work IN those departments WHERE some employees works whose id within the range 100 and 200.
SELECT *
FROM employees
WHERE department_id NOT IN(
    SELECT department_id
    FROM employees
    WHERE employee_id BETWEEN 100 AND 200
);
--22. all the informatiON for those employees whose id is any id who earn the secONd highest salary.
SELECT *
FROM employees
WHERE salary=(
    SELECT max(salary) "maximal salary"
    FROM employees
    WHERE salary<>(
        SELECT max (salary) "maximal salary"
        FROM employees)
);

--23. the employee name( first name and last name ) and hire date for all employees IN the same department as Clara. Exclude Clara.
SELECT
    employee_id,
    first_name || ' ' || last_name name,
    hire_date
FROM employees
WHERE department_id IN (
                        SELECT department_id
                        FROM employees
                        WHERE first_name = 'Clara'
)
  AND first_name<>'Clara';

--24. the employee number and name( first name and last name ) for all employees who work IN a department with any employee whose name cONtains a T.
SELECT
    first_name || ' ' || last_name name,
    row_number() over (ORDER BY first_name ) 'employee number'
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM employees
    WHERE first_name||last_name LIKE '%T%'
);

--25. full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commissiON percentage.

--26. the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work IN a department with any employee with a J IN their name.
SELECT
    first_name || ' ' || last_name name,
    row_number() over (ORDER BY first_name ),
    salary
FROM employees
WHERE salary >(SELECT avg(salary) "average salary" FROM employees)
  AND department_id IN(
                        SELECT department_id
                        FROM employees
                        WHERE first_name||' '||last_name LIKE '%J%'
                        );
--27. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.
SELECT
    first_name || ' ' || last_name name,
    row_number() over (ORDER BY first_name ),
    job_title
FROM employees e
    JOIN jobs j
        ON e.job_id = j.job_id
WHERE salary<(
              SELECT MAX(salary) "maximal salary"
              FROM employees ee
                  JOIN jobs jj
                      ON ee.job_id = jj.job_id
              WHERE ee.job_id = 'MK_MAN'
                );
--28. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
SELECT
    first_name || ' ' || last_name name,
    row_number() over (ORDER BY first_name ),
    job_title
FROM employees e
    JOIN jobs j
        ON e.job_id = j.job_id
WHERE salary<(
    SELECT MIN (salary)
    FROM employees ee
        JOIN jobs jj
            ON ee.job_id = jj.job_id
    WHERE ee.job_id = 'MK_MAN');
--29. all the informatiON of those employees who did NOT have any job IN the past.
SELECT *
FROM employees
WHERE employee_id NOT IN(
    SELECT employee_id
    FROM job_history
);
--30. the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.
SELECT
    row_number() over (ORDER BY first_name ),
    first_name || ' ' || last_name name,
    job_title
FROM employees e
    JOIN jobs j
        ON e.job_id = j.job_id
WHERE salary>(
    SELECT mIN(avg(salary)) "mINimal average salary IN department"
    FROM employees
    GROUP BY department_id
);
--31. the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.
SELECT
    employee_id,
    first_name || ' ' || last_name name,
    CASE job_id
        WHEN 'ST_MAN' THEN 'SALESMAN'
        WHEN 'IT_PROG' THEN 'DEVELOPER'
        ELSE job_id
        END AS ALTERED_JOB_ID
FROM employees;
--32. the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
SELECT
    employee_id,
    first_name || ' ' || last_name name,
    CASE WHEN salary>(
                    SELECT AVG(salary) "average salary"
                    FROM employees
                    )
    THEN 'HIGH'
    ELSE 'LOW'
    END AS SalaryStatus
FROM employees;
--33. the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees)
-- and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than
-- the average salary of all employees.
SELECT
    employee_id,
    first_name || ' ' || last_name name,
    (SELECT AVG(salary) "average salary"
     FROM employees) AvgCompare,
    CASE WHEN salary>(
                    SELECT AVG(salary) "average salary"
                    FROM employees
             )
    THEN 'HIGH'
    ELSE 'LOW'
    END AS SalaryStatus
FROM employees;
--34. all the employees who earn more than the average and who work IN any of the IT departments.
SELECT *
FROM employees
WHERE job_id = 'IT_PROG'
  AND
    salary>(
            SELECT avg(salary) "average salary"
            FROM employees
            );
--35. who earns more than Mr. Ozer.
SELECT *
FROM employees
WHERE salary>(
    SELECT salary
    FROM employees
    WHERE last_name = 'Ozer'
);
--36. which employees have a manager who works for a department based IN the US.
SELECT *
FROM employees
WHERE manager_id IN(
    SELECT manager_id
    FROM departments
    WHERE locatiON_id IN(
        SELECT locatiON_id
        FROM locatiONs
        WHERE country_id=(
            SELECT country_id
            FROM countries
            WHERE country_name = 'United States of America'
        )
    )
);
--37. the names of all employees whose salary is greater than 50% of their department’s total salary bill.
SELECT first_name || ' ' || last_name name
FROM employees OUTER_E
WHERE salary >(
    SELECT SUM(salary)/2
    FROM employees INNER_E
    WHERE INNER_E.department_id = OUTER_E.department_id
);
--38. the employee id, name ( first name and last name ), salary, department name and city for all
--the employees who gets the salary as the salary earn by the employee which is maximum within the joining persON January 1st, 2002 and December 31st, 2003.
SELECT
    first_name || ' ' || last_name name,
    salary,
    D.department_id,
    department_name,
    L.CITY
FROM employees E
    JOIN departments D
         ON(D.department_id=E.department_id)
    JOIN locatiONs L
         ON (D.locatiON_id = L.locatiON_id)
WHERE salary IN (
    SELECT MAX(salary) "maximal salary"
    FROM employees
    WHERE hire_date BETWEEN
        TO_DATE('January 1 2002','MONTH DD YYYY')
        AND
        TO_DATE('December 31, 2003','MONTH DD YYYY')
);
--39. the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list IN descending order ON salary.
SELECT
    first_name || ' ' || last_name name,
    salary,
    department_id
FROM employees
WHERE salary>(
    SELECT avg(salary) "average salary"
    FROM employees
    WHERE department_id=40
)
ORDER BY salary DESC;
--40. the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.
SELECT
    first_name || ' ' || last_name name,
    salary,
    department_id
FROM employees
WHERE salary > (
    SELECT max(salary) "maximal salary IN departament 40"
    FROM employees
    WHERE department_id=40
);
--41. the department name and Id for all departments WHERE they located, that Id is equal to the Id for the locatiON WHERE department number 30 is located.
SELECT
    department_id,
    department_name
FROM departments
WHERE locatiON_id=(
    SELECT locatiON_id
    FROM departments
    WHERE department_id = 30
);
--42. the first and last name, salary, and department ID for all those employees who work IN that department WHERE the employee works who hold the ID 201.
SELECT
    first_name || ' ' || last_name name,
    salary,
    department_id
FROM employees
WHERE department_id=(
    SELECT department_id
    FROM employees
    WHERE employee_id = 201
);
--43. the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works IN that department which ID is 40.
SELECT
    first_name || ' ' || last_name name,
    salary,
    department_id
FROM employees
WHERE salary=(
    SELECT salary
    FROM employees
    WHERE department_id = 40
);
--44. the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40.
SELECT
    first_name || ' ' || last_name name,
    salary,
    department_id
FROM employees
WHERE salary>(
    SELECT mIN(salary) "mINimal salary"
    FROM employees
    WHERE department_id = 40
);
--45. the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.
SELECT
    first_name || ' ' || last_name name,
    salary,
    department_id
FROM employees
WHERE salary<(
    SELECT mIN(salary) "mINimal salary"
    FROM employees
    WHERE department_id = 70
);
--46. the first and last name, salary, and department ID for those employees who earn less than the average salary, and also work at the department WHERE the employee Laura is working as a first name holder.
SELECT
    first_name || ' ' || last_name name,
    salary,
    department_id
FROM employees
WHERE department_id=(
    SELECT department_id
    FROM employees
    WHERE first_name = 'Laura'
)
  AND salary<(
    SELECT avg(salary) "average salary"
    FROM employees
);
--47. the full name (first and last name) of manager who is supervising 4 OR more employees.
SELECT first_name || ' ' || last_name name
FROM employees
WHERE employee_id IN(
    SELECT manager_id
    FROM employees
    GROUP BY manager_id
    HAVING count(employee_id)>=4);
--48. the details of the current job for those employees who worked as a Sales Representative IN the past.
SELECT j.*
FROM employees e
    JOIN jobs j
        ON(e.job_id = j.job_id)
WHERE employee_id IN(
    SELECT employee_id
    FROM job_history
);
--49. all the infromatiON about those employees who earn secONd lowest salary of all the employees.
SELECT *
FROM employees
WHERE salary IN(
    SELECT mIN(salary) "mINimal salary"
    FROM employees
    WHERE salary NOT IN(
        SELECT mIN(salary) "mINimal salary"
        FROM employees
    )
);
--50. the department ID, full name (first and last name), salary for those employees who is highest salary drawar IN a department.
SELECT
    department_id,
    first_name || ' ' || last_name name,
    salary
FROM employees e
where salary IN(
    select max(salary) "maximal salary"
    from employees ee
    where e.department_id=ee.department_id
);

