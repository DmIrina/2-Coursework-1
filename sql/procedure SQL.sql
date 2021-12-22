-- CALL stored_procedure_name (param1, param2, ....) 
-- CALL procedure1(10 , 'string parameter' , @parameter_var);

now() - TIMESTAMP

DELIMITER //
   
CREATE PROCEDURE `p2` () 
LANGUAGE SQL 
DETERMINISTIC
SQL SECURITY DEFINER 
COMMENT 'A procedure'
BEGIN 
	DECLARE today TIMESTAMP DEFAULT CURRENT_DATE; 
	SELECT st.first_name AS "Ім'я", st.last_name AS "Прізвище", gr.name AS "Група", gr.first_year AS "Рік вступу", sp.name AS "Спеціальність", YEAR(today)-gr.first_year+1 as "Курс"
	FROM student as st JOIN coursework.group as gr 
	ON st.group_id = gr.id JOIN specialty as sp
	ON gr.specialty_id = sp.id; 
END //

CALL p2();

DROP procedure  IF EXISTS  p2;

CALL res_exam(2)


DELIMITER // 
CREATE PROCEDURE res_exam(i INT)
     COMMENT 'Повертає результати здавання екзамена групою по студентах'
     begin
        DROP VIEW IF EXISTS report_exam;
        CREATE VIEW report_exam AS 
		SELECT st.first_name, st.last_name, st.record_book_N, s_ctrl.exam_grade, gr.name, ds.name, c_ref.id, c_reg.date, 
		CASE
			WHEN s_ctrl.exam_grade+s_ctrl.year_grade < 60 THEN "Незадовільно"
			WHEN s_ctrl.exam_grade+s_ctrl.year_grade >= 60 AND s_ctrl.exam_grade+s_ctrl.year_grade < 65 THEN "Достатньо"
			WHEN s_ctrl.exam_grade+s_ctrl.year_grade >= 65 AND s_ctrl.exam_grade+s_ctrl.year_grade < 75 THEN "Задовільно"
			WHEN s_ctrl.exam_grade+s_ctrl.year_grade >= 75 AND s_ctrl.exam_grade+s_ctrl.year_grade < 85 THEN "Добре"
			WHEN s_ctrl.exam_grade+s_ctrl.year_grade >= 85 AND s_ctrl.exam_grade+s_ctrl.year_grade < 65 THEN "Дуже добре"
			WHEN s_ctrl.exam_grade+s_ctrl.year_grade >= 95 THEN "Відмінно"
		END AS "Універ.оцін"
		FROM semestr_control as s_ctrl, control_registry as c_reg, group as gr, student as st, discipline as ds
		WHERE s_ctrl.control_registry_id=c_reg.id AND c_reg.discipline_id=ds.id AND c_reg.group_id = gr.id AND c_reg.id = i;        
     END //



CREATE TABLE `log` (
`id` INT( 11 ) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
`msg` VARCHAR( 255 ) NOT NULL,
`time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
`row_id` INT( 11 ) NOT NULL
) ;

CREATE TRIGGER `update_test` 
AFTER INSERT, UPDATE ON student
FOR EACH ROW BEGIN
   INSERT INTO log Set msg = "insert", row_id = NEW.id;
END

-- Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ', UPDATE ON student FOR EACH ROW BEGIN    INSERT INTO log Set msg = 'insert', ro' at line 2
