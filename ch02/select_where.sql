DROP DATABASE IF EXISTS select_practice;
CREATE DATABASE select_practice;
USE select_practice;

CREATE TABLE customer (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50),
  email VARCHAR(50),
  address VARCHAR(100)
);

INSERT INTO customer (name, email, address) VALUES
('김철수', 'kim@example.com', '서울시 강남구'),
('박영희', 'park@example.com', '서울시 서초구'),
('이민수', NULL, '경기도 성남시'),
('최영진', 'choi@example.com', '서울시 송파구'),
('한미영', 'han@example.com', '경기도 수원시'),
('강종현', 'kang@example.com', '서울시 강서구');

-- 샘플 데이터 추가
INSERT INTO customer (name, email, address) VALUES
('홍길동', 'hong@example.com', '부산시 진구');

-- ////////////////////////////////
-- SELECT 구문과 WHERE 절 연습
-- ////////////////////////////////
SELECT * FROM customer;

-- 1. 서울시 강남구에 사는 고객 조회(id, name, address만 조회)
select id, name, address from customer where address = '서울시 강남구';

-- 2. email이 NULL인 고객 조회
-- 이민수의 이메일이 NULL 이다. NULL은 값이 없다가 아니라 값을 모른다에 가깝다.
-- 그래서 email = null; 을 찾고 싶지만 찾아지지 않는다.
-- 즉 null은 등호(=)로 비교할 수 없다. 이때는 is null이라는 값을 사용해야 한다.
select * from customer where email = null;
select * from customer where email is null;

-- 3. 이름이 박영희인 고객 조회
select * from customer where name = '박영희';

-- 4. 서울시에 사는 id 3 이하 고객 조회
select * from customer where address LIKE '서울시%' AND id <= 3;

-- 5. 서울시에 사는 사람이 아닌 사람 조회
select * from customer where address not like '서울시%';

-- 6. 서울시 또는 경기도에 사는 사람 조회
select * from customer where address like '서울시%' or address like'부산시%';

-- 7. id 가 2 ~ 5인 고객 조회
select * from customer where id between 2 and 5;

-- 8. 서울시 강남구, 서울시 서초구, 서울시 송파구에 사는 고객만 조회
select * from customer where address IN('서울시 강남구', '서울시 서초구', '서울시 송파구');

-- 샘플 데이터 2
-- comment 는 컬럼과 테이블에 설명을 달아두는 기능이다.
-- 동작에는 영향을 주지 않지만, 다른 사람이 테이블을 볼 때 도움이 된다.
-- show full columns from student; 로 확인 가능
CREATE TABLE student (
    student_id INT PRIMARY KEY COMMENT '학번',
    name VARCHAR(50) NOT NULL COMMENT '이름',
    grade INT NOT NULL COMMENT '학년',
    major VARCHAR(100) NOT NULL COMMENT '학과'
) comment = '학생 정보 테이블';

select * from student;
show full columns from student;

-- student 샘플 데이터
INSERT INTO student (student_id, name, grade, major)
VALUES
  (1,  '김철수', 1, '컴퓨터공학과'),
  (2,  '박영희', 2, '경영학과'),
  (3,  '이민수', 4, '전자공학과'),
  (4,  '홍길동', 1, '디자인학과'),
  (5,  '임성민', 3, '컴퓨터공학과'),
  (6,  '한지원', 2, '경영학과'),
  (7,  '박준형', 4, '전자공학과'),
  (8,  '김민지', 1, '디자인학과'),
  (9,  '이현수', 3, '컴퓨터공학과'),
  (10, '정미경', 2, '경영학과'),
  (11, '김성진', 4, '전자공학과'),
  (12, '임승환', 1, '디자인학과'),
  (13, '최수빈', 2, '컴퓨터공학과'),
  (14, '오지아', 3, '경영학과'),
  (15, '윤서아', 2, '전자공학과'),
  (16, '장도윤', 4, '디자인학과');

SELECT * FROM student;

-- student 테이블에서 학과가 컴퓨터공학과인 학생들의 학번과 이름 조회
select student_id, name 
from student 
where major = '컴퓨터공학과';

-- 1. grade가 3인 학생들 조회하기 (컬럼을 지정하지 않으면 전부 출력)
select * from student 
where grade =3;

-- 2. 이름이 홍길동인 학생 조회하기
select * from student 
where name = '홍길동';

-- 3. 학번이 1부터 10까지인 학생들 조회하기 (BETWEEN)
select * from student 
where student_id between 1 and 10;

-- 4. 학과가 컴퓨터공학과이면서 학년이 2학년인 학생들만 조회하기
select * from student 
where major = '컴퓨터공학과' and grade = 2;

-- 5. 학과가 컴퓨터공학과이거나 학년이 2학년인 학생들 조회하기
select * from student 
where major = '컴퓨터공학과' or grade = 2;

-- 6. 학생 이름이 홍길동이 아닌 학생들 조회하기
select * from student 
where name != '홍길동';

-- 7. 학년이 2학년 이상인 학생들 조회하기
select * from student 
where grade >= 2 ;

-- 8. 학년이 2학년 미만인 학생들 조회하기
select * from student 
where grade < 2;

-- 9. 학년이 1학년, 3학년, 4학년인 학생들 조회하기 (IN 사용)
select * from student 
where grade IN(1, 3, 4);

-- 10. 이름이 김씨인 학생들 조회하기 (LIKE 사용)
select * from student 
where name like '김%';

-- 11. 컴퓨터공학과이거나 경영학과이면서, 2학년인 학생들 조회하기 (괄호 주의)
select * from student 
where (major = '컴퓨터공학과' or major = '경영학과') and grade = 2;




