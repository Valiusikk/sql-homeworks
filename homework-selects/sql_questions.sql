-- Write a query to display: 
-- 1. the first name, last name, salary, and job grade for all employees.
SELECT
    first_name, last_name, salary, job_title
FROM
    employees
LEFT JOIN
        jobs
        USING (job_id);

SELECT
       first_name, last_name, salary, job_title
FROM
     employees
JOIN
    jobs
    USING (job_id);

SELECT
       first_name, last_name, salary, j.job_title
FROM
     employees e
JOIN
    jobs j
    ON (j.job_id = e.job_id);
-- 2. the first and last name, department, city, and state province for each employee.
SELECT
       first_name, last_name, department_name, city, state_province
FROM
     employees
LEFT JOIN
         departments
         USING (department_id)
LEFT JOIN
         locations
         USING (location_id);

SELECT
       first_name, last_name, department_name, city, state_province
FROM
     employees e
LEFT JOIN
         departments d
        ON(d.department_id = e.department_id)
LEFT JOIN
         locations l
        ON(l.location_id = d.location_id);

-- 3. the first name, last name, department number and department name, for all employees for departments 80 OR 40.
SELECT
       first_name, last_name, d.department_name, d.department_id
FROM
     employees e
LEFT JOIN
         departments d
        ON(d.department_id = e.department_id)
WHERE
      d.department_id = 80
OR
      d.department_id = 40;

SELECT
       first_name, last_name, d.department_name, d.department_id
FROM
     employees e
LEFT JOIN
         departments d
ON
    (d.department_id = e.department_id)
WHERE
      d.department_id IN (80, 40);

-- 4. those employees who contain a letter z  to their first name and also display their last name, department, city, and state province.
SELECT
       last_name, department_name, city, state_province
FROM
     employees e
LEFT JOIN
         departments d
ON
    (d.department_id = e.department_id)
LEFT JOIN
         locations l
ON
    (l.location_id = d.location_id)
WHERE
      e.first_name like '%z%';

SELECT
       last_name, department_name, city, state_province
FROM
     employees e
LEFT JOIN
         departments d
ON
    (d.department_id = e.department_id)
LEFT JOIN
         locations l
ON
    (l.location_id = d.location_id)
WHERE
      instr(e.first_name, 'z') > 0;

-- 5. the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
SELECT
       first_name, last_name, salary
FROM
     employees
WHERE
      salary <(SELECT
                      salary
              FROM
                   employees
              WHERE
                    employee_id = 182);

-- 6. the first name of all employees including the first name of their manager.
SELECT
       e.first_name, d.first_name
FROM
     employees e
JOIN
     employees d
ON
    (e.manager_id = d.employee_id);

-- 7. the first name of all employees and the first name of their manager including those who does not working under any manager.
SELECT
       e.first_name, d.first_name
FROM
     employees e
LEFT JOIN
         employees d
ON
    (e.manager_id = d.employee_id);

-- 8. the details of employees who manage a department.
SELECT
       *
FROM
     employees
WHERE
      employee_id
IN
(SELECT
        manager_id
FROM
     employees);

-- 9. the first name, last name, and department number for those employees who works IN the same department as the employee who holds the last name as Taylor.
SELECT
       first_name, last_name, department_id
FROM
     employees
WHERE
      department_id
IN (SELECT
           department_id
    FROM
         employees
    WHERE
          last_name = 'Taylor');

--10. the department name and number of employees IN each of the department.
SELECT
       department_name, count(*)
FROM
     departments
right JOIN
         employees
        USING(department_id)
GROUP BY
         department_name;

--11. the name of the department, average salary and number of employees working IN that department who got commission.
SELECT
       department_name, avg(salary), count(employee_id)
FROM
     departments
JOIN
    employees
    USING(department_id)
WHERE
      commission_pct is not null
group by
         department_name;

--12. job title and average salary of employees.
SELECT
       job_title, avg(salary)
FROM
     jobs
JOIN
    employees
    USING(job_id)
group by
         job_title;

--13. the country name, city, and number of those departments WHERE at least 2 employees are working.
SELECT
       country_name, city, count(department_name)
FROM
     locations
JOIN
    countries
    USING(country_id)
JOIN
    departments
    USING(location_id)
JOIN
    employees
    USING(department_id)
group by
         country_name, city
having
       count(department_name) > 1;

--14. the employee ID, job name, number of days worked IN for all those jobs IN department 80.
SELECT
       employee_id, job_title, sysdate - hire_date "number of days worked IN"
FROM
     employees
JOIN
    jobs
    USING(job_id)
WHERE
      department_id = 80;

--15. the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
SELECT
       first_name || ' ' || last_name name
FROM
     employees
WHERE
      salary > (SELECT
                       salary
                FROM
                     employees
                WHERE
                      employee_id = 163);

SELECT
       concat(concat(first_name, ' '), last_name) name
FROM
     employees
WHERE
      salary > (SELECT
                       salary
                FROM
                     employees
                WHERE
                      employee_id = 163);

--16. the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.
SELECT
       employee_id, first_name || ' ' || last_name
FROM
     employees
WHERE
      salary > (SELECT
                       avg(salary)
                FROM
                     employees);

--17. the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.
SELECT
       employee_id, first_name || ' ' || last_name, salary
FROM
     employees
WHERE
      manager_id =(SELECT
                          employee_id
                    FROM
                         employees
                    WHERE
                          first_name = 'Payam');

--18. the department number, name ( first name and last name ), job and department name for all employees IN the Finance department.
SELECT
       department_id, first_name || ' ' || last_name, job_title, department_name
FROM
    employees
JOIN
    departments
    USING(department_id)
JOIN
    jobs
    USING(job_id)
WHERE
      department_name = 'Finance';

--19. all the information of an employee whose id is any of the number 134, 159 and 183.
SELECT
       *
FROM
     departments
JOIN
    employees
    USING(department_id)
JOIN
    jobs
    USING(job_id)
JOIN
    locations
    USING(location_id)
JOIN
    job_history
    USING(employee_id)
WHERE
      employee_id IN (134, 159, 183);
--20. all the information of the employees whose salary is within the range of smallest salary and 2500.
SELECT
       *
FROM
     departments
JOIN
    employees
USING
    (department_id)
JOIN
    jobs
USING (job_id)
JOIN
    locations
    USING (location_id)
JOIN
    job_history
    USING (employee_id)
WHERE
      salary > (SELECT
                       min(salary)
                FROM employees)
  AND salary < 2500;
--21. all the information of the employees who does not work IN those departments WHERE some employees works whose id within the range 100 and 200.
SELECT
       *
FROM
     EMPLOYEES
WHERE
      DEPARTMENT_ID not IN(
        SELECT
               DEPARTMENT_ID
        FROM
             EMPLOYEES
        WHERE
              EMPLOYEE_ID between 100 AND 200);
--22. all the information for those employees whose id is any id who earn the second highest salary.
SELECT *
FROM departments
JOIN
    employees
    USING (department_id)
JOIN
    jobs
    USING (job_id)
JOIN
    locations
    USING (location_id)
JOIN
    job_history
    USING (employee_id)
WHERE
  salary =(SELECT
                  max(salary)
            FROM
                 employees
            WHERE salary !=(SELECT
                            max (salary)
                         FROM
                            employees));

--23. the employee name( first name and last name ) and hire date for all employees IN the same department as Clara. Exclude Clara.
SELECT
       employee_id, first_name || ' ' || last_name, hire_date
FROM
     employees
WHERE
      department_id = (SELECT
                              department_id
                        FROM
                             employees
                        WHERE
                              first_name = 'Clara')
    AND first_name!='Clara';

--24. the employee number and name( first name and last name ) for all employees who work IN a department with any employee whose name contains a T.
SELECT
       first_name || ' ' || last_name, row_number() over (order by FIRST_NAME ) 'employee number'
FROM
     EMPLOYEES
WHERE
      DEPARTMENT_ID IN (
            SELECT
                DEPARTMENT_ID
            FROM
                EMPLOYEES
            WHERE
                FIRST_NAME like '%T%');

--25. full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.

--26. the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work IN a department with any employee with a J IN their name.
SELECT
       first_name || ' ' || last_name name, row_number() over (order by FIRST_NAME ),salary
FROM
     EMPLOYEES
WHERE
      SALARY >(SELECT
                      avg(SALARY)
                FROM EMPLOYEES)
                    AND
                    DEPARTMENT_ID
                    IN(SELECT
                              DEPARTMENT_ID
                    FROM
                         EMPLOYEES
                    WHERE
                          FIRST_NAME||' '||LAST_NAME like '%J%');
--27. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.
SELECT
       first_name || ' ' || last_name name, row_number() over (order by FIRST_NAME ),job_title
FROM
     EMPLOYEES
JOIN
    JOBS
USING
    (job_id)
WHERE
      SALARY<(
          SELECT
                 MAX(SALARY)
          FROM
               EMPLOYEES
          JOIN
                JOBS
        USING (job_id)
          WHERE
                JOB_ID = 'MK_MAN');
--28. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
SELECT
        first_name || ' ' || last_name name, row_number() over (order by FIRST_NAME ),job_title
FROM
    EMPLOYEES
        JOIN
    JOBS
    USING
        (job_id)
WHERE
        SALARY<(
        SELECT
            MIN (SALARY)
        FROM
            EMPLOYEES
                JOIN
            JOBS
            USING (job_id)
        WHERE
                JOB_ID = 'MK_MAN');
--29. all the information of those employees who did not have any job IN the past.
SELECT
       *
FROM
     EMPLOYEES
WHERE
      EMPLOYEE_ID not IN(
          Select
                 EMPLOYEE_ID
          FROM
               JOB_HISTORY);
--30. the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.
SELECT
       row_number() over (order by FIRST_NAME ),first_name || ' ' || last_name name, JOB_TITLE
FROM
     EMPLOYEES
JOIN
    JOBS
    USING(job_id)
WHERE
      SALARY>(SELECT
                     min(avg(SALARY))
            FROM
                 EMPLOYEES
                 group by DEPARTMENT_ID);
--31. the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.
SELECT EMPLOYEE_ID,FIRST_NAME || ' ' || LAST_NAME name,
       CASE JOB_ID
           WHEN 'ST_MAN' THEN 'SALESMAN'
           WHEN 'IT_PROG' THEN 'DEVELOPER'
           ELSE JOB_ID
           END AS ALTERED_JOB_ID
FROM employees;
--32. the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
SELECT
       EMPLOYEE_ID,FIRST_NAME || ' ' || LAST_NAME name,
CASE WHEN
        SALARY>(SELECT
                     AVG(SALARY)
                 FROM
                     EMPLOYEES)
THEN
    'HIGH'
ELSE
     'LOW'
END AS
    SalaryStatus
FROM
     employees;
--33. the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees)
-- and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than
-- the average salary of all employees.
SELECT
       EMPLOYEE_ID,FIRST_NAME || ' ' || LAST_NAME name,
       (SELECT
               AVG(SALARY)
       FROM
            EMPLOYEES) AvgCompare,
CASE WHEN
         SALARY>(SELECT
                         AVG(SALARY)
                     FROM
                         EMPLOYEES)
THEN
   'HIGH'
ELSE
   'LOW'
END AS
   SalaryStatus
FROM
     EMPLOYEES;
--34. all the employees who earn more than the average and who work IN any of the IT departments.
SELECT
       *
FROM
     EMPLOYEES
WHERE
      JOB_ID = 'IT_PROG'
  AND
      SALARY>(SELECT
                     avg(SALARY)
                FROM
                    EMPLOYEES);
--35. who earns more than Mr. Ozer.
SELECT
       *
FROM
     EMPLOYEES
WHERE
      SALARY>(SELECT
                     SALARY
              FROM
                    EMPLOYEES
              WHERE
                   LAST_NAME = 'Ozer');
--36. which employees have a manager who works for a department based IN the US.
SELECT
       *
FROM
     EMPLOYEES
WHERE
      MANAGER_ID
      IN(SELECT
                MANAGER_ID
      FROM
           DEPARTMENTS
      WHERE
            LOCATION_ID
            IN (SELECT
                       LOCATION_ID
            FROM
                 LOCATIONS
            WHERE
                  COUNTRY_ID  =(SELECT
                                       COUNTRY_ID
                                FROM
                                     COUNTRIES
                                WHERE
                                      COUNTRY_NAME = 'United States of America')));
--37. the names of all employees whose salary is greater than 50% of their department’s total salary bill.
SELECT
       first_name || ' ' || last_name name
FROM
     EMPLOYEES OUTER_E
WHERE
      SALARY >(SELECT
                      SUM(SALARY)/2
               FROM
                    EMPLOYEES INNER_E
               WHERE
                     INNER_E.DEPARTMENT_ID = OUTER_E.DEPARTMENT_ID);
--38. the employee id, name ( first name and last name ), salary, department name and city for all
--the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.
SELECT
        first_name || ' ' || last_name name,SALARY,D.DEPARTMENT_ID,DEPARTMENT_NAME,L.CITY
FROM
    EMPLOYEES E
        JOIN
    DEPARTMENTS D
    ON(D.DEPARTMENT_ID=E.DEPARTMENT_ID)
        JOIN
    LOCATIONS L
    ON (D.LOCATION_ID = L.LOCATION_ID)
WHERE
        SALARY IN (SELECT
                       MAX(SALARY)
                   FROM
                       EMPLOYEES
                   WHERE
                       HIRE_DATE between
                           TO_DATE('January 1 2002','MONTH DD YYYY')
                           AND
                           TO_DATE('December 31, 2003','MONTH DD YYYY'));
--39. the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list IN descending order ON salary.
SELECT
        first_name || ' ' || last_name name,SALARY,DEPARTMENT_ID
FROM
    EMPLOYEES
WHERE
      SALARY > (SELECT
                       avg(SALARY)
                FROM
                     EMPLOYEES
                WHERE
                      DEPARTMENT_ID=40)
order by SALARY desc;
--40. the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.
SELECT
        first_name || ' ' || last_name name,SALARY,DEPARTMENT_ID
FROM
    EMPLOYEES WHERE SALARY > (SELECT max(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID=40);
--41. the department name and Id for all departments WHERE they located, that Id is equal to the Id for the location WHERE department number 30 is located.
SELECT
       DEPARTMENT_ID,DEPARTMENT_NAME
FROM
     DEPARTMENTS
WHERE
      LOCATION_ID = (SELECT
                            LOCATION_ID
                     FROM
                          DEPARTMENTS
                     WHERE
                           DEPARTMENT_ID = 30);
--42. the first and last name, salary, and department ID for all those employees who work IN that department WHERE the employee works who hold the ID 201.
SELECT
        first_name || ' ' || last_name name,SALARY,DEPARTMENT_ID
FROM
    EMPLOYEES
WHERE
      DEPARTMENT_ID = (SELECT
                              DEPARTMENT_ID
                       FROM
                            EMPLOYEES
                       WHERE
                             EMPLOYEE_ID = 201);
--43. the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works IN that department which ID is 40.
SELECT
        first_name || ' ' || last_name name,SALARY,DEPARTMENT_ID
FROM
    EMPLOYEES
WHERE
      SALARY = (SELECT
                       SALARY
                FROM
                     EMPLOYEES
                WHERE
                      DEPARTMENT_ID = 40);
--44. the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40.
SELECT
        first_name || ' ' || last_name name,SALARY,DEPARTMENT_ID
FROM
    EMPLOYEES
WHERE
      SALARY>(SELECT
                     min(SALARY)
              FROM
                   EMPLOYEES
              WHERE
                    DEPARTMENT_ID = 40);
--45. the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.
SELECT
        first_name || ' ' || last_name name,SALARY,DEPARTMENT_ID
FROM
    EMPLOYEES
WHERE
      SALARY<(SELECT
                     min(SALARY)
              FROM
                   EMPLOYEES
              WHERE
                    DEPARTMENT_ID = 70);
--46. the first and last name, salary, and department ID for those employees who earn less than the average salary, and also work at the department WHERE the employee Laura is working as a first name holder.
SELECT
        first_name || ' ' || last_name name,SALARY,DEPARTMENT_ID
FROM
    EMPLOYEES
WHERE
      DEPARTMENT_ID = (SELECT
                              DEPARTMENT_ID
                       FROM
                            EMPLOYEES
                       WHERE
                             FIRST_NAME = 'Laura')
AND
      SALARY<(SELECT
                     avg(SALARY)
              FROM
                   EMPLOYEES);
--47. the full name (first and last name) of manager who is supervising 4 OR more employees.
SELECT
       first_name || ' ' || last_name name
FROM
     EMPLOYEES
WHERE
      EMPLOYEE_ID IN(SELECT
                            MANAGER_ID,count(*)
                  FROM
                       EMPLOYEES
                  group by
                           MANAGER_ID
                           having count(EMPLOYEE_ID)>=4);
--48. the details of the current job for those employees who worked as a Sales Representative IN the past.
SELECT
       j.*
FROM
     EMPLOYEES e
JOIN
         JOBS j
         ON(e.JOB_ID = j.JOB_ID)
WHERE
      EMPLOYEE_ID IN(
          SELECT
                EMPLOYEE_ID
          FROM
                JOB_HISTORY) ;
--49. all the infromation about those employees who earn second lowest salary of all the employees.
SELECT
       *
FROM
     EMPLOYEES
WHERE
      SALARY IN (
          SELECT
                 min(SALARY)
          FROM
               EMPLOYEES
          WHERE
                SALARY not IN(
                    SELECT
                           min(SALARY)
                    FROM EMPLOYEES));
--50. the department ID, full name (first and last name), salary for those employees who is highest salary drawar IN a department.

