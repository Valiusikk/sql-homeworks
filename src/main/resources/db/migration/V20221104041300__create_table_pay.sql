create table PAY(
    cardNr VARCHAR(16) PRIMARY KEY,
    employee_id NUMBER(8),
    salary NUMBER(8, 2),
    commission_pct NUMBER(2, 2),
    foreign key (employee_id) references EMPLOYEES(employee_id)
);