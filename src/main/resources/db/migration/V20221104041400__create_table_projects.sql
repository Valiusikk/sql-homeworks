CREATE TABLE projects
(
    project_id NUMBER(6) PRIMARY KEY,
    project_description VARCHAR(1000) NOT NULL ,
    project_investment NUMBER(10, -3) NOT NULL ,
    project_revenue NUMBER(10, -3),
    CONSTRAINT prjct_description_min CHECK ( LENGTH(project_description) > 10 ),
    CONSTRAINT prjct_investment_min CHECK ( project_investment > 0 )
);