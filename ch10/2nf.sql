CREATE DATABASE IF NOT EXISTS normalization;
USE normalization;

DROP TABLE IF EXISTS enrollment_bad;

-- 일부러 2NF 를 위반한 테이블
CREATE TABLE enrollment_bad (
    student_id   INT         NOT NULL,
    student_name VARCHAR(50) NOT NULL,   -- 학생ID 만으로 결정됨
    subject_code VARCHAR(10) NOT NULL,
    subject_name VARCHAR(50) NOT NULL,   -- 과목코드 만으로 결정됨
    professor    VARCHAR(30) NOT NULL,   -- 과목코드 만으로 결정됨
    grade        CHAR(1),
    PRIMARY KEY (student_id, subject_code)
);

INSERT INTO enrollment_bad VALUES
(1, '홍길동', 'MAT101', '수학', '김교수', 'A'),
(1, '홍길동', 'SCI101', '과학', '이교수', 'B'),
(2, '이순신', 'MAT101', '수학', '김교수', 'C'),
(2, '이순신', 'ENG101', '영어', '박교수', 'A'),
(3, '김유신', 'SCI101', '과학', '이교수', 'B');

SELECT * FROM enrollment_bad;
-- 한 테이블에 학생 정보, 과목 정보, 성적이 모두 들어가 있다.
-- 홍길동 이름 2번, 수학과 김교수 2번씩 중복된 데이터 확인

-- 1. 갱신 이상 - 수학 담당 교수를 바꿀 대 한 행만 고치면 담당교수가 2명이 되어버림.
-- 2. 삭제 이상 - 수강 기록을 지우려다 수강 과목 자체가 사라진다.
-- 3. 삽입 이상 - 학생 없이 과목을 등록할 수 없다.

-- 기본키가 1개라면 2정규화 만족, 복합 기본키라면 반드시 2정규화 확인 필요

-- 2정규화를 위반한 테이블을 고쳐보기
-- 학생 정보 테이블 : 학생ID로만 결정되는 것들 분리
create table student_2nf(
	student_id int primary key auto_increment,
    student_name varchar(50) not null
);

-- 과목 정보 테이블 : 과목코드로만 결정되는 것들 분리
create table subject_2nf(
	subject_code varchar(50) primary key,
    subject_name varchar(50) not null,
    professor varchar(50) not null
);

create table enrollment_2nf(
	student_id int not null,
    subject_code varchar(50) not null,
    grade char(1),
    primary key(student_id, subject_code),
    foreign key(student_id) references student_2nf(student_id),
    foreign key(subject_code) references subject_2nf(subject_code)
);

-- 데이터 입력
INSERT INTO student_2nf VALUES
(1, '홍길동'),
(2, '이순신'),
(3, '김유신');

INSERT INTO subject_2nf VALUES
('MAT101', '수학', '김교수'),
('SCI101', '과학', '이교수'),
('ENG101', '영어', '박교수');

INSERT INTO enrollment_2nf VALUES
(1, 'MAT101', 'A'),
(1, 'SCI101', 'B'),
(2, 'MAT101', 'C'),
(2, 'ENG101', 'A'),
(3, 'SCI101', 'B');

select * from student_2nf;
select * from subject_2nf;
select * from enrollment_2nf;

-- 1. 수강 정보 전체 조회(학생 이름 + 과목명 + 성적)
select s.student_name, sb.subject_name, e.grade
from enrollment_2nf e
join subject_2nf sb
on sb.subject_code = e.subject_code 
join student_2nf s
on e.student_id = s.student_id;

-- 2. 수학 담당교수를 '신교수'로 수정
update subject_2nf set professor = '신교수' where subject_name = '수학';

-- 3. 과목별 수강생 수
select s.subject_name as 과목, count(*) as 수강생수
from subject_2nf s
left join enrollment_2nf e
on s.subject_code = e.subject_code
group by subject_name;