DROP DATABASE IF EXISTS group_practice;
CREATE DATABASE group_practice;
USE group_practice;

DROP TABLE IF EXISTS tb_student;
-- IF EXISTS : 해당 테이블이 존재할 경우에만 삭제하도록 조건을 거는 옵션

CREATE TABLE tb_student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    class CHAR(1) NOT NULL,
    score INT NOT NULL
);

INSERT INTO tb_student (name, class, score) VALUES
('김민수', 'A', 85),
('이서연', 'B', 75),
('박지훈', 'A', 65),
('최예린', 'A', 70),
('정하윤', 'B', 95),
('강동현', 'C', 88),
('오소연', 'C', 92),
('한지민', 'B', 78),
('윤태양', 'A', 85),
('문채원', 'C', 90);

SELECT * FROM tb_student order by class asc;

-- 1. 클래스(A, B, C) 별 평균을 구해보자.
select  class, round(avg(score), 2) as 평균
from tb_student
group by class
having avg(score) >=80;

-- 2. 클래스(A, B, C) 별 평균을 구해보자.(평균이 80점 이상)
select  class, round(avg(score), 2) as 평균
from tb_student
group by class
having avg(score) >=80;

-- 3. 클래스별 최고 및 최저 점수
select class, salariesmax(score) as 최고점수, min(score) as 최저점수
from tb_student
group by class;

-- 4. select 절에 비집계 컬럼을 넣어보기
select class, max(score) as 최고점수, min(score) as 최저점수, name
from tb_student
group by class;

-- 실습 문제 : 학생 수가 4명 이상인 반의 반 이름, 인원수, 평균 점수를 조회하세요. 평균 점수는 소수점 둘째 자리까지 표시
select class, count(*) as 인원수, round(avg(score), 2) as 평균점수
from tb_student
group by class
having count(*) >= 4;