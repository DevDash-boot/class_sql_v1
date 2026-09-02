DROP DATABASE IF EXISTS type_practice;
CREATE DATABASE type_practice;
USE type_practice;

-- 학생 테이블
create table student(
	student_id int primary key,
    name varchar(50) not null,
    grade TINYINT not null,
    major varchar(50) not null,
    admission_date date not null,
    notes text
);

INSERT INTO student (student_id, name, grade, major, admission_date, notes)
VALUES
    (1001, '김지영', 1, '컴퓨터공학', '2026-03-02', '프로그래밍에 뛰어남'),
    (1002, '이민수', 2, '수학', '2025-03-02', NULL),
    (1003, '박소연', 3, '물리학', '2024-03-02', '양자역학에 관심 많음');

SELECT * FROM student;
    
-- 과목 테이블
create table subject(
	subject_id int primary key,
    subject_code CHAR(4) not null,
    subject_name varchar(20) not null,
    credit int not null,
    department_code CHAR (2) not null,
    professor varchar(20) not null,
    created_at datetime not null
);

INSERT INTO subject (subject_id, subject_code, subject_name, credit, department_code, professor, created_at)
VALUES
    (1, 'CS01', '데이터베이스 시스템', 3, 'CS', '김영희', '2026-03-02 10:00:00'),
    (2, 'MA01', '미적분학', 4, 'MA', '이철수', '2026-03-02 09:00:00'),
    (3, 'PH01', '양자물리학', 3, 'PH', '박민준', '2026-03-02 11:00:00');

SELECT * FROM subject;

-- 수강 기록 테이블
create table enrollment(
	enrollment_id int primary key,
    student_id int not null,
    subject_id int not null,
    score decimal(5,2) not null,
    enrolled_at datetime not null
);

INSERT INTO enrollment (enrollment_id, student_id, subject_id, score, enrolled_at)
VALUES
    (1, 1001, 1, 85.50, '2026-03-02 12:00:00'),
    (2, 1002, 2, 92.00, '2026-03-02 12:30:00'),
    (3, 1003, 3, 78.75, '2026-03-02 13:00:00');

SELECT * FROM enrollment;