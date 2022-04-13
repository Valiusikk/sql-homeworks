CREATE OR REPLACE PROCEDURE employment_logging(
                                    employmentAction CHAR(5),
                                    firstName VARCHAR(20),
                                    lastName  VARCHAR(20)
                                               )
IS
BEGIN
    INSERT INTO employment_logs(first_name, last_name, employment_action, employment_status_updtd_tmstmp)
                         VALUES(firstName, lastName, employmentAction, CURRENT_TIMESTAMP);
END;