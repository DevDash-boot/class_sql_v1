DROP DATABASE IF EXISTS green_school;
CREATE DATABASE green_school;
USE green_school;

CREATE TABLE tb_grade (
    grade CHAR(1) PRIMARY KEY,
    score INT
);

CREATE TABLE tb_student (
    no INT NOT NULL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    gender ENUM('F', 'M') NOT NULL,
    age INT,
    grade CHAR(1),
    FOREIGN KEY (grade) REFERENCES tb_grade(grade)
);

-- tb_grade 데이터 삽입
INSERT INTO tb_grade (grade, score) VALUES
    ('A', 100),
    ('B', 80),
    ('C', 60),
    ('D', 40),
    ('E', 20),
    ('F', 0);

-- tb_student 데이터 삽입
INSERT INTO tb_student (no, name, gender, age, grade) VALUES
    (20170001, '조이',   'F', 25, 'B'),
    (20170020, '앤드류', 'M', 26, 'B'),
    (20180800, '데이지', 'F', 24, 'A'),
    (20190123, '다나',   'F', 23, 'A'),
    (20201000, '스카이', 'M', 22, 'D'),
    (20210001, '제임스', 'M', 21, NULL);
-- 제임스의 성적이 NULL이다. 이 때문에 JOIN 종류별 결과가 달라진다.
-- C, E, F학점인 학생이 없는 상태

SELECT * FROM tb_grade;
SELECT * FROM tb_student;

-- INNER JOIN 특수한 형태 (CROSS JOIN)
select * from tb_student
join tb_grade;
-- on 조건식 : 현재 join 구문에 on 조건절이 없는 상태 -> CROSS JOIN

select count(*) from tb_grade;

-- INNER JOIN
select * from tb_student 
inner join tb_grade
on tb_grade.grade = tb_student.grade;
-- on : tb_grade의 grade와 tb_student의 grade가 같은 컬럼만 찾는다.

select * from tb_student s
inner join tb_grade g
on g.grade = s.grade;
-- tb_student에 s라는 별칭을, tb_grade에 g라는 별칭을 주어서 코드를 줄일 수 있다.

-- OUTER JOIN : LEFT JOIN - 학생 명단이 다 나온다.(조이, 앤드류, 데이지, 다나, 스카이, 제임스)
select * from tb_student s
left join tb_grade g
on g.grade = s.grade;

-- OUTER JOIN : RIGHT JOIN - 성적 정보가 다 나온다.(A, B, C, D, E, F)
select * from tb_student s
right join tb_grade g
on g.grade = s.grade;

-- 추가 테이블 생성 및 데이터 수정
CREATE TABLE tb_club (
    club_id   INT PRIMARY KEY,
    club_name VARCHAR(20)
);

INSERT INTO tb_club VALUES (1, '축구부'), (2, '밴드부');

ALTER TABLE tb_student ADD COLUMN club_id INT;
ALTER TABLE tb_student ADD FOREIGN KEY (club_id) REFERENCES tb_club(club_id);

UPDATE tb_student SET club_id = 1 WHERE no = 20170001;  -- 조이
UPDATE tb_student SET club_id = 2 WHERE no = 20170020;  -- 앤드류
UPDATE tb_student SET club_id = 1 WHERE no = 20180800;  -- 데이지
-- 다나, 스카이, 제임스는 동아리 없음 (club_id 가 NULL)

SELECT * FROM tb_student;

-- 학생 정보 + 등급 점수 + 동아리 이름
select s.*, g.score, c.club_name 
from tb_student s
left join tb_grade g
on s.grade = g.grade
left join tb_club c
on s.club_id = c.club_id;

-- 연습문제 1. INNER JOIN - 등급이 'A' 또는 'B'인 학생 조회
select s.name, s.age, s.grade, g.score 
from tb_student s
inner join tb_grade g
on s.grade = g.grade
where s.grade IN ('A', 'B');

-- 연습문제 2. LEFT JOIN - 모든 남학생의 이름, 등급, 점수를 조회
-- 등급이 없는 학생도 표시
select s.name, s.grade, g.score  
from tb_student s
left join tb_grade g
on s.grade = g.grade
where s.gender = 'M';

-- 연습문제 3. LEFT JOIN - 나이가 24세 이하인 학생의 이름, 나이, 등급, 점수 조회
-- 등급이 없는 학생도 표시
select s.name, s.age, s.grade, g.score
from tb_student s
left join tb_grade g
on s.grade = g.grade
where s.age <= 24;

-- 연습문제 4. RIGHT JOIN - 점수가 60 이상인 이름, 등급, 점수 조회
-- 학생이 없는 등급도 표시
select s.name, s.grade, g.score
from tb_student s
right join tb_grade g
on s.grade = g.grade
where g.score >= 60;