-- ------------- 1 ---------------------
SELECT s.last_name AS "Прізвище", s.first_name AS "Ім'я", g.name AS "Група", sp.name AS "Спеціальність"
FROM student AS s
LEFT JOIN coursework.group AS g ON 
s.group_id = g.id
LEFT JOIN specialty as sp ON 
g.specialty_id = sp.id WHERE s.last_name = "Білий";


-- ----------------------- 2 ----------------------
SELECT s.last_name AS "Прізвище", s.first_name AS "Ім'я", s.record_book_N AS "№ заліковки", sp.N AS "Спеціальність"
FROM student AS s
LEFT JOIN coursework.group AS g ON 
s.group_id = g.id
LEFT JOIN specialty as sp ON 
g.specialty_id = sp.id WHERE s.record_book_N = "КЗ-0101";

-- ------------------------- 3 --------------
SELECT st.last_name AS "Прізвище", st.first_name AS "Ім'я", d.name AS "Дисципліна", ct.name AS "Тип контролю", sc.year_grade + sc.exam_grade + ap.points AS "Балл" 
FROM student AS st
LEFT JOIN additional_points as ap ON
st.addpoints_id = ap.id
RIGHT JOIN semestr_control AS sc ON 
st.id = sc.student_id
LEFT JOIN control_registry AS cr ON
sc.control_registry_id = cr.id
LEFT JOIN discipline AS d ON
cr.discipline_id = d.id
LEFT JOIN control_type AS ct ON
cr.control_type_id = ct.id WHERE last_name = "Сірко";

-- --------------------------- 4 ---------------------

SELECT st.last_name AS "Прізвище", st.first_name AS "Ім'я", d.name AS "Дисципліна", sc.year_grade + sc.exam_grade + ap.points AS "Балл" 
FROM student AS st
LEFT JOIN additional_points as ap ON
st.addpoints_id = ap.id
RIGHT JOIN semestr_control AS sc ON 
st.id = sc.student_id 
LEFT JOIN control_registry AS cr ON
sc.control_registry_id = cr.id
LEFT JOIN discipline AS d ON
cr.discipline_id = d.id WHERE sc.year_grade + sc.exam_grade + ap.points < 60 ORDER BY last_name;

-- ------------------ 5 ------------------

SELECT DISTINCT st.last_name AS "Прізвище", st.first_name AS "Ім'я" 
FROM student AS st
LEFT JOIN additional_points as ap ON
st.addpoints_id = ap.id
RIGHT JOIN semestr_control AS sc ON 
st.id = sc.student_id 
WHERE sc.year_grade + sc.exam_grade + ap.points < 60;

-- ---------------------- 6 ----------------------

SELECT st.last_name AS "Прізвище", st.first_name AS "Ім'я", AVG(sc.exam_grade + sc.exam_grade + ap.points) AS "Балл" 
FROM student AS st
LEFT JOIN additional_points as ap ON
st.addpoints_id = ap.id
RIGHT JOIN semestr_control AS sc ON 
st.id = sc.student_id 
LEFT JOIN control_registry AS cr ON
sc.control_registry_id = cr.id
 ORDER BY last_name;

-- ------------------------------------------------
SELECT st.last_name AS "Прізвище", st.first_name AS "Ім'я", sc.year_grade + sc.exam_grade + ap.points AS "Балл" 
FROM student AS st
LEFT JOIN additional_points as ap ON
st.addpoints_id = ap.id
RIGHT JOIN semestr_control AS sc ON 
st.id = sc.student_id ;





