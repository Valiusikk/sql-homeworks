CREATE TABLE hours_worked(
    employee_id NUMBER(8) NOT NULL,
    project_id NUMBER (8) not null,
    amount_of_hours NUMBER(16) not null,
    primary key (employee_id,project_id)
);