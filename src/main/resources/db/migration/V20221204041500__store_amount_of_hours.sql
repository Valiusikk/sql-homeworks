CREATE TABLE hours_worked(
    employee_id NUMBER(8) NOT NULL,
    project_id NUMBER (8) NOT NULL,
    amount_of_hours NUMBER(16) NOT NULL,
    PRIMARY KEY (employee_id,project_id)
);