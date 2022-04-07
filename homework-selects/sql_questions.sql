-- Write a query to display: 
-- 1. the first name, last name, salary, and job grade for all employees.
SELECT
    first_name, last_name, salary, job_title
FROM
    employees
LEFT JOIN
        jobs
        USING (job_id);

select
       first_name, last_name, salary, job_title
from
     employees
join
    jobs
    using (job_id);

select
       first_name, last_name, salary, j.job_title
from
     employees e
join
    jobs j
    on (j.job_id = e.job_id);
-- 2. the first and last name, department, city, and state province for each employee.
select
       first_name, last_name, department_name, city, state_province
from
     employees
left join
         departments
         using (department_id)
left join
         locations
         using (location_id);

select
       first_name, last_name, department_name, city, state_province
from
     employees e
left join
         departments d
        ON(d.department_id = e.department_id)
left join
         locations l
        ON(l.location_id = d.location_id);

-- 3. the first name, last name, department number and department name, for all employees for departments 80 or 40.
select
       first_name, last_name, d.department_name, d.department_id
from
     employees e
left join
         departments d
        ON(d.department_id = e.department_id)
where
      d.department_id = 80
or
      d.department_id = 40;

select
       first_name, last_name, d.department_name, d.department_id
from
     employees e
left join
         departments d
ON
    (d.department_id = e.department_id)
where
      d.department_id in (80, 40);

-- 4. those employees who contain a letter z  to their first name and also display their last name, department, city, and state province.
select
       last_name, department_name, city, state_province
from
     employees e
left join
         departments d
ON
    (d.department_id = e.department_id)
left join
         locations l
ON
    (l.location_id = d.location_id)
where
      e.first_name like '%z%';

select
       last_name, department_name, city, state_province
from
     employees e
left join
         departments d
ON
    (d.department_id = e.department_id)
left join
         locations l
ON
    (l.location_id = d.location_id)
where
      instr(e.first_name, 'z') > 0;

-- 5. the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
select
       first_name, last_name, salary
from
     employees
where
      salary <(select
                      salary
              from
                   employees
              where
                    employee_id = 182);

-- 6. the first name of all employees including the first name of their manager.
select
       e.first_name, d.first_name
from
     employees e
join
     employees d
on
    (e.manager_id = d.employee_id);

-- 7. the first name of all employees and the first name of their manager including those who does not working under any manager.
select
       e.first_name, d.first_name
from
     employees e
left join
         employees d
on
    (e.manager_id = d.employee_id);

-- 8. the details of employees who manage a department.
select
       *
from
     employees
where
      employee_id
in
(select
        manager_id
from
     employees);

-- 9. the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
select
       first_name, last_name, department_id
from
     employees
where
      department_id
in (select
           department_id
    from
         employees
    where
          last_name = 'Taylor');

--10. the department name and number of employees in each of the department.
select
       department_name, count(*)
from
     departments
right join
         employees
        using(department_id)
GROUP BY
         department_name;

--11. the name of the department, average salary and number of employees working in that department who got commission.
select
       department_name, avg(salary), count(employee_id)
from
     departments
join
    employees
    using(department_id)
where
      commission_pct is not null
group by
         department_name;

--12. job title and average salary of employees.
select
       job_title, avg(salary)
from
     jobs
join
    employees
    using(job_id)
group by
         job_title;

--13. the country name, city, and number of those departments where at least 2 employees are working.
select
       country_name, city, count(department_name)
from
     locations
join
    countries
    using(country_id)
join
    departments
    using(location_id)
join
    employees
    using(department_id)
group by
         country_name, city
having
       count(department_name) > 1;

--14. the employee ID, job name, number of days worked in for all those jobs in department 80.
select
       employee_id, job_title, sysdate - hire_date "number of days worked in"
from
     employees
join
    jobs
    using(job_id)
where
      department_id = 80;

--15. the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
select
       first_name || ' ' || last_name name
from
     employees
where
      salary > (select
                       salary
                from
                     employees
                where
                      employee_id = 163);

select
       concat(concat(first_name, ' '), last_name) name
from
     employees
where
      salary > (select
                       salary
                from
                     employees
                where
                      employee_id = 163);

--16. the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.
select
       employee_id, first_name || ' ' || last_name
from
     employees
where
      salary > (select
                       avg(salary)
                from
                     employees);

--17. the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.
select
       employee_id, first_name || ' ' || last_name, salary
from
     employees
where
      manager_id =(select
                          employee_id
                    from
                         employees
                    where
                          first_name = 'Payam');

--18. the department number, name ( first name and last name ), job and department name for all employees in the Finance department.
select
       department_id, first_name || ' ' || last_name, job_title, department_name
from
    employees
join
    departments
    using(department_id)
join
    jobs
    using(job_id)
where
      department_name = 'Finance';

--19. all the information of an employee whose id is any of the number 134, 159 and 183.
select
       *
from
     departments
join
    employees
    using(department_id)
join
    jobs
    using(job_id)
join
    locations
    using(location_id)
join
    job_history
    using(employee_id)
where
      employee_id in (134, 159, 183);
--20. all the information of the employees whose salary is within the range of smallest salary and 2500.
select
       *
from
     departments
join
    employees
using
    (department_id)
join
    jobs
using (job_id)
join
    locations
    using (location_id)
join
    job_history
    using (employee_id)
where
      salary > (select
                       min(salary)
                from employees)
  and salary < 2500;
--21. all the information of the employees who does not work in those departments where some employees works whose id within the range 100 and 200.
select
       *
from
     EMPLOYEES
where
      DEPARTMENT_ID not in(
        select
               DEPARTMENT_ID
        from
             EMPLOYEES
        where
              EMPLOYEE_ID between 100 and 200);
--22. all the information for those employees whose id is any id who earn the second highest salary.
select *
from departments
join
    employees
    using (department_id)
join
    jobs
    using (job_id)
join
    locations
    using (location_id)
join
    job_history
    using (employee_id)
where
  salary =(select
                  max(salary)
            from
                 employees
            where salary !=(select
                            max (salary)
                         from
                            employees));

--23. the employee name( first name and last name ) and hire date for all employees in the same department as Clara. Exclude Clara.
select
       employee_id, first_name || ' ' || last_name, hire_date
from
     employees
where
      department_id = (select
                              department_id
                        from
                             employees
                        where
                              first_name = 'Clara')
    and first_name!='Clara';

--24. the employee number and name( first name and last name ) for all employees who work in a department with any employee whose name contains a T.
select
       first_name || ' ' || last_name, row_number() over (order by FIRST_NAME ) 'employee number'
from
     EMPLOYEES
where
      DEPARTMENT_ID in (
            select
                DEPARTMENT_ID
            from
                EMPLOYEES
            where
                FIRST_NAME like '%T%');

--25. full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.

--26. the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.
select
       first_name || ' ' || last_name name, row_number() over (order by FIRST_NAME ),salary
from
     EMPLOYEES
where
      SALARY >(select
                      avg(SALARY)
                from EMPLOYEES)
                    and
                    DEPARTMENT_ID
                    in(select
                              DEPARTMENT_ID
                    from
                         EMPLOYEES
                    where
                          FIRST_NAME||' '||LAST_NAME like '%J%');
--27. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.
select
       first_name || ' ' || last_name name, row_number() over (order by FIRST_NAME ),job_title
from
     EMPLOYEES
join
    JOBS
using
    (job_id)
where
      SALARY<(
          select
                 MAX(SALARY)
          from
               EMPLOYEES
          join
                JOBS
        using (job_id)
          where
                JOB_ID = 'MK_MAN');
--28. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
select
        first_name || ' ' || last_name name, row_number() over (order by FIRST_NAME ),job_title
from
    EMPLOYEES
        join
    JOBS
    using
        (job_id)
where
        SALARY<(
        select
            MIN (SALARY)
        from
            EMPLOYEES
                join
            JOBS
            using (job_id)
        where
                JOB_ID = 'MK_MAN');
--29. all the information of those employees who did not have any job in the past.
select
       *
from
     EMPLOYEES
where
      EMPLOYEE_ID not in(
          Select
                 EMPLOYEE_ID
          from
               JOB_HISTORY);
--30. the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.

--31. the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.

--32. the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
--33. the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees)
-- and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than
-- the average salary of all employees.
--34. all the employees who earn more than the average and who work in any of the IT departments.
select
       *
from
     EMPLOYEES
where
      JOB_ID = 'IT_PROG'
  and
      SALARY>(select
                     avg(SALARY)
                from
                    EMPLOYEES);
--35. who earns more than Mr. Ozer.
select
       *
from
     EMPLOYEES
where
      SALARY>(select
                     SALARY
              from
                    EMPLOYEES
              where
                   LAST_NAME = 'Ozer');
--36. which employees have a manager who works for a department based in the US.
select
       *
from
     EMPLOYEES
where
      MANAGER_ID
      in(select
                MANAGER_ID
      from
           DEPARTMENTS
      where
            LOCATION_ID
            in (select
                       LOCATION_ID
            from
                 LOCATIONS
            where
                  COUNTRY_ID  =(select
                                       COUNTRY_ID
                                from
                                     COUNTRIES
                                where
                                      COUNTRY_NAME = 'United States of America')));
--37. the names of all employees whose salary is greater than 50% of their department’s total salary bill.

--38. the employee id, name ( first name and last name ), salary, department name and city for all
--the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.  
--39. the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list in descending order on salary.
--40. the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.
--41. the department name and Id for all departments where they located, that Id is equal to the Id for the location where department number 30 is located.
--42. the first and last name, salary, and department ID for all those employees who work in that department where the employee works who hold the ID 201.
--43. the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works in that department which ID is 40.
--44. the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40.
--45. the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.
--46. the first and last name, salary, and department ID for those employees who earn less than the average salary, and also work at the department where the employee Laura is working as a first name holder.
--47. the full name (first and last name) of manager who is supervising 4 or more employees.

--48. the details of the current job for those employees who worked as a Sales Representative in the past.

--49. all the infromation about those employees who earn second lowest salary of all the employees.
select
       *
from
     EMPLOYEES
where
      SALARY in (
          select
                 min(SALARY)
          from
               EMPLOYEES
          where
                SALARY not in(
                    select
                           min(SALARY)
                    from EMPLOYEES));
--50. the department ID, full name (first and last name), salary for those employees who is highest salary drawar in a department.

