-- 앞 차시에서 만든 student 테이블이 남아있으면 지우고 시작
DROP TABLE IF EXISTS student;

CREATE TABLE student (
  id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  grade INT NOT NULL,
  major VARCHAR(50) NOT NULL,
  english_score INT NOT NULL
);

INSERT INTO student (id, name, grade, major, english_score) VALUES
(1, '홍길동', 1, '컴퓨터공학과', 85),
(2, '김영희', 2, '경영학과', 90),
(3, '이철수', 3, '컴퓨터공학과', 78),
(4, '박민지', 1, '디자인학과', 92),
(5, '최재영', 4, '전자공학과', 88),
(6, '강영식', 2, '컴퓨터공학과', 95);

select * from student;

CREATE TABLE student (
  id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  grade INT NOT NULL,
  major VARCHAR(50) NOT NULL,
  english_score INT NOT NULL,
  -- major 열에 인덱스 생성
  index idx_major (major)
);

-- 1. 기존 테이블에 인덱스를 추가하는 방법
alter table student
add index idx_grade (grade);

-- 2. 인덱스 확인 명령어
show index from student;

-- 3. 복합 인덱스 생성 (여러 열을 조합한 인덱스)
create index idx_grade_major on student (grade, major);

-- 4. 인덱스 삭제
drop index idx_grade on student;