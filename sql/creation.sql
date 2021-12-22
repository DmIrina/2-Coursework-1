CREATE DATABASE IF NOT EXISTS coursework;
USE coursework;

CREATE SCHEMA IF NOT EXISTS coursework;
USE coursework;

-- -----------------------------------------------------
-- --------------- coursework.faculty-------------------
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS coursework.faculty (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  full_name VARCHAR(100) NOT NULL UNIQUE,
  short_name VARCHAR(10) NOT NULL UNIQUE);

-- -----------------------------------------------------
-- --------------- coursework.cathedra------------------
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS coursework.cathedra (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  full_name VARCHAR(50) NOT NULL UNIQUE,
  short_name VARCHAR(10) NOT NULL UNIQUE,
  faculty_id INT NOT NULL,
  CONSTRAINT fk_cathedra_faculty FOREIGN KEY (faculty_id)
    REFERENCES coursework.faculty (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- --------------- coursework.group---------------------
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS coursework.group (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  name VARCHAR(5) NOT NULL,
  first_year YEAR NOT NULL CHECK (first_year >= 2017),
  department_id INT NOT NULL,
  specialty_id INT NOT NULL,
  CONSTRAINT fk_group_department FOREIGN KEY (department_id)
    REFERENCES coursework.cathedra (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_group_specialty FOREIGN KEY (specialty_id)
    REFERENCES coursework.specialty (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- --------------- coursework.proffesor-----------------
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS coursework.proffesor (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  last_name VARCHAR(45) NOT NULL,
  first_name VARCHAR(20) NOT NULL,
  second_name VARCHAR(45) NOT NULL,
  position VARCHAR(45) NOT NULL,
  academic_degree VARCHAR(45) NOT NULL,
  academic_rank VARCHAR(45) NOT NULL,
  department_id INT NOT NULL,
  CONSTRAINT fk_proffesor_cathedra FOREIGN KEY (cathedra_id)
    REFERENCES coursework.cathedra (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- --------------- coursework.discipline----------------
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS coursework.discipline (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL UNIQUE,
  hours INT NOT NULL CHECK (hours>= 30 AND hours <=150));

-- -----------------------------------------------------
-- --------------- coursework.student-------------------
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS coursework.student (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  last_name VARCHAR(45) NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  second_name VARCHAR(45) NOT NULL,
  record_book_N VARCHAR(7) NOT NULL UNIQUE,
  group_id INT NOT NULL,
  addpoints_id INT NOT NULL,
  CONSTRAINT fk_student_group FOREIGN KEY (group_id)
    REFERENCES coursework.group (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_student_addpoints_id
    FOREIGN KEY (addpoints_id)
    REFERENCES additional_points (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- --------------- coursework.control_type--------------
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS coursework.control_type (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL UNIQUE);

-- -----------------------------------------------------
-- --------------- coursework.specialty-----------------
-- -----------------------------------------------------
  
CREATE TABLE IF NOT EXISTS coursework.specialty (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL UNIQUE,
  N INT NOT NULL UNIQUE);

-- -----------------------------------------------------
-- --------------- coursework.control_registry----------
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS coursework.control_registry (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  discipline_id INT NOT NULL,
  `date` DATETIME NOT NULL,
  control_type_id INT NOT NULL,
  group_id INT NOT NULL,
  proffesor_id INT NOT NULL,
  CONSTRAINT fk_control_registry_control_type FOREIGN KEY (control_type_id)
    REFERENCES coursework.control_type (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_control_registry_discipline FOREIGN KEY (discipline_id)
    REFERENCES coursework.discipline (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_control_registry_group FOREIGN KEY (group_id)
    REFERENCES coursework.group (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_control_registry_proffesor
    FOREIGN KEY (proffesor_id)
    REFERENCES coursework.proffesor (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- --------------- coursework.semestr_control----------
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS coursework.semestr_control (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  student_id INT NOT NULL,
  control_registry_id INT NOT NULL,
  year_grade INT NOT NULL DEFAULT 0,
  exam_grade INT NOT NULL DEFAULT 0,
  CONSTRAINT fk_semestr_control_student FOREIGN KEY (student_id)
    REFERENCES coursework.student (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_semestrcontrol_controlregistry FOREIGN KEY (control_registry_id)
    REFERENCES coursework.control_registry (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- --------------- coursework.additional_points---------
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS coursework.additional_points (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  merit VARCHAR(45) NOT NULL,
  points INT NOT NULL CHECK (points >= 0));

-- ------------------fixing tables------------

DROP TABLE IF EXISTS coursework.additional_points;



ALTER TABLE coursework.semestr_control
DROP FOREIGN KEY fk_semestrcontrol_controlregistry;

ALTER TABLE coursework.control_registry
DROP id;

ALTER TABLE coursework.control_registry
ADD COLUMN id INT PRIMARY KEY NOT NULL AUTO_INCREMENT;

ALTER TABLE coursework.group
ADD CONSTRAINT fk_group_specialty FOREIGN KEY (specialty_id)
    REFERENCES coursework.specialty (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE coursework.group
DROP specialty;

ALTER TABLE coursework.additional_points
MODIFY COLUMN points INT DEFAULT 0;
    
ALTER TABLE coursework.specialty
ADD COLUMN N INT NOT NULL UNIQUE;

