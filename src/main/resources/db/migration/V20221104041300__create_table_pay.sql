create table PAY(
    cardNr VARCHAR(16) PRIMARY KEY,
    employee_id NUMBER(8),
    salary NUMBER(8, 2),
    commission_pct NUMBER(2, 2),
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEES(employee_id)
);