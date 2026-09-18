-- 일부러 1NF 를 위반한 테이블
CREATE TABLE 수강생 (
    학생ID   INT          PRIMARY KEY,
    이름     VARCHAR(20)  NOT NULL,
    수강과목 VARCHAR(100) NOT NULL    -- 한 칸에 여러 값을 쉼표로 넣는다
);

INSERT INTO 수강생 VALUES
(1, '홍길동', '자바, MySQL, 스프링'),
(2, '이순신', 'MySQL, 파이썬'),
(3, '김유신', '자바');

SELECT * FROM 수강생;

-- 위반 사례 1. 
-- 조건 1. 모든 컬럼은 원자값만 저장되어야 한다.
-- 한 칸에 여러값을 쉼표로 넣고 있다.

-- MySQL을 듣는 학생을 모두 조회하라.
-- 0건이 결과로 나옴
select 이름 from 수강생 where 수강과목 = 'MySQL';

-- 원하지 않는 과목까지 함께 출력됨
select * from 수강생 where 수강과목 like '%MySQL%';

-- 1NF 적용
-- 위반 사례 1. 한 칸에 여러 값 -> 해결해보기(수강 과목을 별도 테이블로 분리)
create table enrollment(
	id int primary key auto_increment,
    subject varchar(50) not null,
    student_id int not null,
    foreign key (student_id) references student(id)
);

INSERT INTO enrollment(student_id, subject) VALUES
(1, '자바'),
(1, 'MySQL'),
(1, '스프링'),
(2, 'MySQL'),
(2, '파이썬'),
(3, '자바');

SELECT * FROM enrollment;

-- 위반 사례 2. 반복그룹 -> 해결해보기()전화번호를 별도 테이블로
CREATE TABLE student_phone (
    id         INT         PRIMARY KEY AUTO_INCREMENT,
    student_id INT         NOT NULL,
    tel        VARCHAR(20) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(id)
);

INSERT INTO student_phone (student_id, tel) VALUES
(1, '010-1111-1111'),
(1, '010-2222-2222'),   -- 홍길동 두 번째 번호
(2, '010-3333-3333'),
(3, '010-5555-5555'),
(3, '010-6666-6666'),   -- 김유신 두 번째 번호
(3, '010-7777-7777');   -- 김유신 세 번째 번호

SELECT * FROM student_phone;

-- 위반 사례 3. 기본키 없음 -> 해결해보기(기본키 추가)
CREATE TABLE student(
	id int primary key auto_increment,
    name varchar(50) not null,
    address varchar(100)
);
insert into student (name, address) values
('홍길동', '서울시 강남구'),
('이순신', '서울시 서초구'),
('김유신', '부산시 진구');

-- id가 생겼으므로 동명이인 있어도 한 사람을 정확히 지목할 수 있다.
select * from student;
update student set address = '서울시 송파구' where id = 1;

-- ////////////////////
-- 1정규화 적용 후
-- ////////////////////
select * from student;
select * from enrollment;
select * from student_phone;

-- 문제 1. MySQL을 듣는 학생 조회
select s.id, s.name, e.subject
from student s
join enrollment e
on s.id = e.student_id
where subject = 'MySQL';

-- 문제 2. 학생과 수강과목 전체 조회
select s.id, s.name, e.subject
from student s
join enrollment e
on s.id = e.student_id;

-- 문제 3. 학생별 수강과목 수
select s.id, s.name, count(e.id) as 수강과목수
from student s
left join enrollment e
on s.id = e.student_id
group by s.id;