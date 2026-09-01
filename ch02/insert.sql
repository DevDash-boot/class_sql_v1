-- 실습 준비
-- insert_practice라는 DB가 있으면 통째로 삭제.
-- insert_practice라는 DB가 아무일도 없이 넘어감.
drop database if exists insert_practice;

-- 데이터베이스 생성
create database insert_practice;

-- insert_practice DB로 사용한다.
use insert_practice;

-- student 테이블 생성
create table student(
	student_id int primary key,
    name varchar(50) not null,
    grade int not null, 
    major varchar(50) not null default '미정'
);

-- 1. 한 건씩 넣기
insert into student(student_id, name, grade, major)  values (1, '홍길동', 3, '컴퓨터공학과');
insert into student(student_id, name, grade, major)  values (2, '김철수', 4, '전자공학과');
insert into student(student_id, name, grade, major)  values (3, '이영희', 2, '경영학과');

select * from student;

-- 2.  여러 건 한 번에 넣기
insert into student(student_id, name, grade, major)  
values 	(4, '박민수', 1, '전자공학과'),
			(5, '최지아', 2, '컴퓨터공학과'),
			(6, '한수연', 3, '경영학과');


-- 제약 조건 1 : PRIMARY KEY
-- 여러 건을 한 번에 넣을 때 그 중 하나만 중복이어도 블록 전체가 들어가지 않는다.
insert into student(student_id, name, grade, major)  
values 	(7, '야스오', 3, '컴퓨터공학과'),
		(1, '티모', 3, '컴퓨터공학과'),
        (3, '애쉬', 3, '컴퓨터공학과');
        
-- 제약 조건 2 : NOT NULL
-- NOT NULL로 설정한 값을 비워두면 에러가 발생합니다.
insert into student(student_id, name, grade) values(9, null, 1);
insert into student(student_id,  grade) values(9, 1);

-- 제약 조건 3 : default
-- 방법 1. 디폴트에 값을 넣는 방법
insert into student(student_id, name, grade, major)
values 	(10, '이순신', 1, DEFAULT), 
		(11, '유관순', 3, '전자공학과');

-- 방법 2. 디폴트에 값을 넣는 방법
insert into student(student_id, name, grade)
values 	(12, '길동이', 1), 
		(13, '고길동', 3);

-- /////////////////////////
-- DATE 타입에 값 넣기
-- /////////////////////////

-- ORDER은 ORDER BY에서 사용한다.
-- 예약어를 이름으로 사용하려면 백틱(``)으로 감싸야 한다.
-- 하지만 가능한 예약어를 사용하지 않고 orders처럼 사용하는 것이 좋다.
create table `order`(
	id int primary key,
    customer_note varchar(50),
    product_name varchar(20) not null,
    quantity int not null,
    order_date DATE not null
);
select * from `order`;

-- 날짜를 넣는 두 가지 방식
-- 방법 1. 따옴표('')로 감싸는 방법
insert into `order`(id, customer_note, product_name, quantity, order_date)
values (1, '빠른 배송', '신라면', 2, '2026-09-01');

-- 방법 2. 하이픈 없는 숫자
insert into `order`(id, customer_note, product_name, quantity, order_date)
values (2, '문 앞 배송', '짜장라면', 3, 20260901);

-- 잘못된 날짜는 걸러진다.
-- 1년은 12개월인데 22월을 넣을 경우
insert into `order`(id, customer_note, product_name, quantity, order_date)
values (4, '테스트', '비빔라면', 3, 20260901);

-- /////////////////////////
-- AUTO_INCREMENT
-- /////////////////////////

create table customer(
	id int auto_increment primary key,
    name varchar(50) not null,
    email varchar(50),
    address varchar(100) not null
);

select * from customer;

-- id 컬럼을 적지 않아도 됨
-- 새 행을 넣을 때마다 자동으로 1씩 올려주는 기능이다.
-- 주로 PRIMARY KEY에 많이 사용한다.
insert into customer(name, email, address) 
values 	('김철수', 'a@naver.com', '서울'),
		('홍길동', 'b@naver.com', '경기'),
		('고길동', 'c@naver.com', '인천');
        
-- AUTO_INCREMENT 에 알아두면 좋은 두 가지
-- 직접 값을 지정하면 그 다음 번호가 이어진다.
insert into customer(id, name, email, address)  values 	(10, '둘둘둘', 'j@naver.com', '부산');
insert into customer(name, email, address)  values 	('삼삼삼', 'h@naver.com', '대전');
		
-- 삭제해도 번호는 돌아오지 않는다.
delete from customer where id = 11;
insert into customer(name, email, address)  values 	('사사사', 'i@naver.com', '강원');


create table post(
	id int auto_increment primary key,
    title varchar(100) not null,
    content text,
    writer varchar(20) not null,
    views int default 0,
    write_date datetime default CURRENT_TIMESTAMP
);
select * from post;
insert into post (title, content, writer) values('흥부와 놀부', '1111111111111', '작자미상');
insert into post values (2, '어린왕자', '어린왕자~~~~~', '생텍쥐페리', 10000, 19430406);
