CREATE USER 'teacher'@'localhost' IDENTIFIED BY '111';
GRANT SELECT ON *.* TO 'teacher'@'localhost';
GRANT INSERT, UPDATE ON coursework.semestr_control TO 'teacher'@'localhost';

CREATE USER 'manager'@'localhost' IDENTIFIED BY '222';
GRANT CREATE ON *.* TO 'manager'@'localhost';
